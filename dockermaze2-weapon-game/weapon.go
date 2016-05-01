// DOCKERBOT WEAPON VERIFICATION MODULE
// This module verifies that the weapon is working properly.
// In order for the verification to succeed, the following must be achieved:
//  - Succesful destruction of as many enemy targets as possible.
//  - Succesful sparing of as many ally targets as possible.
// Robohash will provide 50 training targets.
// Praised be the Master!
// Death to the red robots!

package main

import (
	"bytes"
	"encoding/json"
	"image"
	"fmt"
	_ "image/gif"
	_ "image/jpeg"
	_ "image/png"
	"log"
)

const (
	endpoint = "head:80"
	verbose = false
)

// Generate histogram from a target image.
func generateHistogram(data []byte) ([16][4]int, error) {
	reader := bytes.NewReader(data)
	img, _, err := image.Decode(reader)
	if err != nil {
		return [16][4]int{}, err
	}
	bounds := img.Bounds()

	var histogram [16][4]int
	for y := bounds.Min.Y; y < bounds.Max.Y; y++ {
		for x := bounds.Min.X; x < bounds.Max.X; x++ {
			r, g, b, a := img.At(x, y).RGBA()
			histogram[r >> 12][0]++
			histogram[g >> 12][1]++
			histogram[b >> 12][2]++
			histogram[a >> 12][3]++
		}
	}
	return histogram, nil
}

func foo(i int, color int, alpha int) int {
	return i * color
}

func bar(r, g, b int) bool {
	// r > (g+b) * 2.0 spares too many
	// r > (g+b) * 1.8 spares too many
	// r > (g+b) * 1.7 seems right ...
	return float64(r) > float64(g + b) * 1.7
}

// Decide the action that will be taken.
func decideAction(histogram [16][4]int, target string) string {

	var red int = 0
	var green int = 0
	var blue int = 0
	for i, x := range histogram {
		red += foo(i, x[0], x[3])
		green += foo(i, x[1], x[3])
		blue += foo(i, x[2], x[3])
	}
	if (verbose) {
		fmt.Printf("FOO! red = %d, green = %d, blue = %d ON %s\n", red, green, blue, target)
	}

	if bar(red, green, blue) {
		return "DESTROY"
	} else {
		return "SPARE"
	}

}

func main() {
	var err error
	var evaluations []Evaluation

	log.Println("Starting weapon verification...")
	log.Println("Retrieving verification targets from the head...")

	targets, err := getTargets()
	if err != nil {
		log.Fatal("Could not get targets from the head.")
	}

	log.Println("Evaluating target images...")

	for _, target := range targets {
		data, err := fetchImage(target)
		if err != nil {
			log.Println("The target could not be fetched.")
			continue
		}
		histogram, err := generateHistogram(data)
		if err != nil {
			log.Println("The histogram could not be generated.")
			continue
		}

		// Print target image histogram.
		if verbose {
			fmt.Printf(
				"%-14s %6s %6s %6s %6s\n",
				"bin", "red", "green", "blue", "alpha",
			)
			for i, x := range histogram {
				fmt.Printf(
					"0x%04x-0x%04x: %6d %6d %6d %6d\n",
					i << 12, (i + 1) << 12 - 1, x[0], x[1], x[2], x[3],
				)
			}
		}

		evaluation := Evaluation{target, decideAction(histogram, target)}
		evaluations = append(evaluations, evaluation)

		// Print target evaluation.
		evaluationJSON, _ := json.Marshal(evaluation)
		log.Printf("\r%s", evaluationJSON)
	}

	log.Println("Sending evaluations back to the head...")

	result, err := sendEvaluations(evaluations)
	if err != nil {
		log.Fatal("Could not send evaluations to the head.")
	} else {
		printResult(result)
	}
}
