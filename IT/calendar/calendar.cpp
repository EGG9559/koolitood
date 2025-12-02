#include <iostream>
#include <iomanip>
#include <ctime>
#ifdef _WIN32
#include <windows.h>
#endif
using namespace std;

#define RESET  "\033[0m"
#define GREEN  "\033[32m"

void enableANSI() {
#ifdef _WIN32
    HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
    if (hOut == INVALID_HANDLE_VALUE) return;
    DWORD dwMode = 0;
    if (!GetConsoleMode(hOut, &dwMode)) return;
    dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
    SetConsoleMode(hOut, dwMode);
#endif
}

int main() {
    enableANSI();  // make sure colors work on Windows

    time_t t = time(NULL);
    tm* timePtr = localtime(&t);
    int year = timePtr->tm_year + 1900;
    int month = timePtr->tm_mon + 1;
    int today = timePtr->tm_mday;
    int daysInMonth;

    while (true) {
        // Days in month
        if (month == 2) {
            if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
                daysInMonth = 29;
            else
                daysInMonth = 28;
        } else if (month == 4 || month == 6 || month == 9 || month == 11)
            daysInMonth = 30;
        else
            daysInMonth = 31;

        cout << "Month: " << month << "/" << year << "\n";
        cout << "Sun Mon Tue Wed Thu Fri Sat\n";

        tm firstDay = {};
        firstDay.tm_year = year - 1900;
        firstDay.tm_mon = month - 1;
        firstDay.tm_mday = 1;
        mktime(&firstDay);
        int firstDayOfWeek = firstDay.tm_wday;

        int currentDay = 1;
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 7; j++) {
                if (i == 0 && j < firstDayOfWeek) {
                    cout << "    ";
                } else if (currentDay > daysInMonth) {
                    cout << "    ";
                } else {
                    bool isToday = (year == timePtr->tm_year + 1900 &&
                                    month == timePtr->tm_mon + 1 &&
                                    currentDay == today);
                    if (isToday)
                        cout << GREEN << setw(4) << right << currentDay << RESET;
                    else
                        cout << setw(4) << right << currentDay;
                    currentDay++;
                }
            }
            cout << '\n';
            if (currentDay > daysInMonth) break;
        }

        cout << "do a thing (n = next month, p = previous month, q = quit): ";
        char cmd;
        cin >> cmd;
        cout << '\n';

        if (cmd == 'n') {
            if (++month > 12) { month = 1; year++; }
        } else if (cmd == 'p') {
            if (--month < 1) { month = 12; year--; }
        } else if (cmd == 'q') break;
        else cout << "Invalid input.\n";
    }

    return 0;
}

