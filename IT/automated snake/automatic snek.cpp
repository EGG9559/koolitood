#include <conio.h>
#include <iostream>
#include <windows.h>
#include <cstdlib> // for rand()
#include <ctime>   // for time()
using namespace std;

// height and width of the boundary
const int width = 80;
const int height = 20;

// Snake head coordinates of snake (x-axis, y-axis)
int x, y;
// Food coordinates
int fruitCordX, fruitCordY;
// variable to store the score of the player
int playerScore;
// Array to store the coordinates of snake tail (x-axis, y-axis)
int snakeTailX[100], snakeTailY[100];
// variable to store the length of the snake's tail
int snakeTailLen;
// for storing snake's moving direction
enum snakesDirection { STOP = 0, LEFT, RIGHT, UP, DOWN };
// snakesDirection variable
snakesDirection sDir;
// boolean variable for checking game is over or not
bool isGameOver;

// Function to initialize game variables
void GameInit() {
    isGameOver = false;
    sDir = STOP;
    x = width / 2;
    y = height / 2;
    fruitCordX = rand() % (width - 1);
    fruitCordY = rand() % (height - 1);
    playerScore = 0;
    snakeTailLen = 0;
}

// Function for creating the game board & rendering
void GameRender(string playerName) {
    // Clears the screen by printing new lines
    cout << string(100, '\n');

    // Creating top walls with '-'
    for (int i = 0; i < width + 2; i++)
        cout << "-";
    cout << endl;

    for (int i = 0; i < height; i++) {
        for (int j = 0; j <= width; j++) {
            // Creating side walls with '|'
            if (j == 0 || j == width)
                cout << "|";
            else if (i == y && j == x)
                cout << "B"; // Snake's head
            else if (i == fruitCordY && j == fruitCordX)
                cout << "#"; // Fruit
            else {
                bool prTail = false;
                for (int k = 0; k < snakeTailLen; k++) {
                    if (snakeTailX[k] == j && snakeTailY[k] == i) {
                        cout << "o"; // Snake tail
                        prTail = true;
                        break;
                    }
                }
                if (!prTail)
                    cout << " ";
            }
        }
        cout << endl;
    }

    // Creating bottom walls with '-'
    for (int i = 0; i < width + 2; i++)
        cout << "-";
    cout << endl;

    // Display player's score
    cout << playerName << "'s Score: " << playerScore << endl;
}

// Function for updating the game state
void UpdateGame() {
    int prevX = snakeTailX[0];
    int prevY = snakeTailY[0];
    int prev2X, prev2Y;
    snakeTailX[0] = x;
    snakeTailY[0] = y;

    for (int i = 1; i < snakeTailLen; i++) {
        prev2X = snakeTailX[i];
        prev2Y = snakeTailY[i];
        snakeTailX[i] = prevX;
        snakeTailY[i] = prevY;
        prevX = prev2X;
        prevY = prev2Y;
    }

    switch (sDir) {
    case LEFT:
        x--;
        break;
    case RIGHT:
        x++;
        break;
    case UP:
        y--;
        break;
    case DOWN:
        y++;
        break;
    default:
        break;
    }

    // Checks for snake's collision with the wall (|)
    if (x >= width || x < 0 || y >= height || y < 0)
        isGameOver = true;

    // Checks for collision with the tail (o)
    for (int i = 0; i < snakeTailLen; i++) {
        if (snakeTailX[i] == x && snakeTailY[i] == y)
            isGameOver = true;
    }

    // Checks for snake's collision with the food (#)
    if (x == fruitCordX && y == fruitCordY) {
        playerScore += 10;
        fruitCordX = rand() % (width - 1);
        fruitCordY = rand() % (height - 1);
        snakeTailLen++;
    }
}

// Function to handle user input
void UserInput() {
    if (_kbhit()) {
        switch (_getch()) {
        case 'a':
        case 'A':
            sDir = LEFT;
            break;
        case 'd':
        case 'D':
            sDir = RIGHT;
            break;
        case 'w':
        case 'W':
            sDir = UP;
            break;
        case 's':
        case 'S':
            sDir = DOWN;
            break;
        case 'x':
        case 'X':
            isGameOver = true;
            break;
        }
    }
}

// Function to generate a random player name
string GenerateRandomName() {
    string names[] = {
        "Goofie", "Bobertus", "Zoomer", "Sneaky", "Slink", "Bytey",
        "Chompus", "NomNom", "Wiggly", "Booper", "LilSlither", "Slinky"
    };
    int numNames = sizeof(names) / sizeof(names[0]);
    return names[rand() % numNames];
}

// Main function / game loop
int main() {
    srand(time(0)); // seed RNG

    // Generate random name
    string playerName = GenerateRandomName();

    // Random difficulty (1–3)
    int randomChoice = (rand() % 3) + 1;
    int dfc;

    switch (randomChoice) {
    case 1: dfc = 150; break; // Easy
    case 2: dfc = 100; break; // Medium
    case 3: dfc = 50; break;  // Hard
    }

    cout << "Starting Snake with player: " << playerName << endl;
    cout << "Difficulty: " << (randomChoice == 1 ? "Easy" :
                               randomChoice == 2 ? "Medium" : "Hard") << endl;
    Sleep(2000); // short pause before start

    GameInit();
    while (!isGameOver) {
        GameRender(playerName);
        UserInput();
        UpdateGame();
        Sleep(dfc);
    }

    cout << "\nGame over for the random silly! Final score for " << playerName << ": " << playerScore << endl;

    // 🟢 Prevent console from closing immediately
    cout << "\nPress Enter to exit...";
    cin.ignore();
    cin.get();

    return 0;
}