## D1: Data Types ##

clearing [whitespace](http://www.cplusplus.com/reference/istream/ws) with `getline` and `ws`and [setting precision](http://www.cplusplus.com/reference/iomanip/setprecision)

```cpp
if (getline(cin >> ws, s2){
    ii = stoi(s2);
    getline(cin, s2);
    dd = stod(s2);
    getline(cin, ss);
}

cout << fixed << setprecision(1) << dd + d << endl;
```
