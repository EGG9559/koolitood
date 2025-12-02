#include <ncurses.h>
#include <cstdlib>
#include <ctime>
#include <vector>
using namespace std;

// Game board size
const int width = 40;
const int height = 20;

// Snake info
int headX, headY;
vector<int> tailX, tailY;
int tailLength;
int fruitX, fruitY;
int score;
bool gameOver;

// Direction enum
enum Direction { STOP = 0, LEFT, RIGHT, UP, DOWN };
Direction dir;

// Initialize the game
void GameInit() {
    gameOver = false;
    dir = STOP;
    headX = width / 2;
    headY = height / 2;
    tailLength = 0;
    tailX.clear();
    tailY.clear();
    score = 0;
    srand(time(0));
    fruitX = rand() % width;
    fruitY = rand() % height;
}

// Draw the game board
void Draw() {
    clear(); // ncurses clear screen

    // Top wall
    for (int i = 0; i < width + 2; i++) printw("-");
    printw("\n");

    for (int yPos = 0; yPos < height; yPos++) {
        for (int xPos = 0; xPos < width; xPos++) {
            if (xPos == 0) printw("|");

            if (xPos == headX && yPos == headY)
                printw("O"); // snake head
            else if (xPos == fruitX && yPos == fruitY)
                printw("#"); // fruit
            else {
                bool printed = false;
                for (int k = 0; k < tailLength; k++) {
                    if (tailX[k] == xPos && tailY[k] == yPos) {
                        printw("o");
                        printed = true;
                        break;
                    }
                }
                if (!printed) printw(" ");
            }

            if (xPos == width - 1) printw("|");
        }
        printw("\n");
    }

    // Bottom wall
    for (int i = 0; i < width + 2; i++) printw("-");
    printw("\n");

    printw("Score: %d\n", score);
    printw("Use WASD to move, Q to quit.\n");
    refresh();
}

// Input handling
void Input() {
    int ch = getch();
    switch (ch) {
        case 'a':
        case 'A':
            dir = LEFT; break;
        case 'd':
        case 'D':
            dir = RIGHT; break;
        case 'w':
        case 'W':
            dir = UP; break;
        case 's':
        case 'S':
            dir = DOWN; break;
        case 'q':
        case 'Q':
            gameOver = true; break;
    }
}

// Game logic update
void Logic() {
    // Update tail positions
    if (tailLength > 0) {
        tailX.insert(tailX.begin(), headX);
        tailY.insert(tailY.begin(), headY);
        if ((int)tailX.size() > tailLength) {
            tailX.pop_back();
            tailY.pop_back();
        }
    }

    // Move head
    switch (dir) {
        case LEFT:  headX--; break;
        case RIGHT: headX++; break;
        case UP:    headY--; break;
        case DOWN:  headY++; break;
        default: break;
    }

    // Collision with walls
    if (headX < 0 || headX >= width || headY < 0 || headY >= height)
        gameOver = true;

    // Collision with tail
    for (int i = 0; i < tailLength; i++) {
        if (tailX[i] == headX && tailY[i] == headY)
            gameOver = true;
    }

    // Eating fruit
    if (headX == fruitX && headY == fruitY) {
        score += 10;
        fruitX = rand() % width;
        fruitY = rand() % height;
        tailLength++;
    }
}

int main() {
    // Initialize ncurses
    initscr();
    cbreak();
    noecho();
    curs_set(0);
    keypad(stdscr, TRUE);
    nodelay(stdscr, TRUE); // non-blocking input

    GameInit();

    while (!gameOver) {
        Draw();
        Input();
        Logic();
        napms(100); // sleep 100ms for game speed
    }

    // Game over screen
    clear();
    printw("Game Over! Final Score: %d\n", score);
    printw("Press any key to exit...\n");
    nodelay(stdscr, FALSE);
    getch();

    endwin(); // restore terminal
    return 0;
}
