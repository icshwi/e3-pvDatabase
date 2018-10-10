# 4.3.0-remove-cout-in-pvDatabase-destructor.p0.patch

pvDatabase has the constant string out when it is destructed. The master branch has a debug level to suppress this message. After 4.3.0, we can simply ignore this patch.

* created by Jeong Han Lee, han.lee@esss.se
* https://github.com/epics-base/pvDatabaseCPP/blob/master/src/database/pvDatabase.cpp
* Wednesday, October 10 10:27:10 CEST 2018
