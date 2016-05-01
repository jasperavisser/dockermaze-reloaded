# MazeSolver enables DockerMaze LEGS robot module resolve ASCII Art mazes.
# Unfortunately, LEGS robot module is damaged and is not possible assemble
# it successfully.
# Repair MazeSolver library in order to provide high performance DockerMaze
# LEGS module that can be assembled to your robot.

from maze_lib.astar import AStar


def format_step(start, end):
    if end[0] > start[0] and end[1] == start[1]:
        return "RIGHT"
    elif end[0] < start[0] and end[1] == start[1]:
        return "LEFT"
    elif end[1] > start[1] and end[0] == start[0]:
        return "DOWN"
    elif end[1] < start[1] and end[0] == start[0]:
        return "UP"
    else:
        raise Exception("hmm: ", start, end)


def format_path(path):
    result = []
    p = path[0]
    for q in path[1:]:
        result.append(format_step(p, q))
        p = q
    return " ".join(result)


class MazeSolver:
    def __init__(self, maze):
        self.verbose = False
        self.maze = maze.split('\n')
        self.width = len(self.maze[0])
        self.height = len(self.maze)
        self.start = (0, 1)
        self.end = (self.width - 1, self.height - 2)

    def solve_maze(self):

        walls = self.create_walls()
        if self.verbose: self.print_maze()
        if self.verbose: self.print_walls(walls)

        solver = AStar()
        solver.init_grid(self.width, self.height, walls, self.start, self.end)
        path = solver.solve()

        return format_path(path)

    def create_walls(self):
        walls = []
        for y, row in enumerate(self.maze):
            for x, cell in enumerate(row):
                if cell != ' ': walls.append((x, y))
        return walls

    def print_maze(self):
        for row in self.maze: print row

    def print_walls(self, walls):
        for y in range(0, self.height):
            row = []
            for x in range(0, self.width):
                if (x, y) in walls:
                    row.append(str(x % 10))
                else:
                    row.append(" ")
            print "".join(row)
