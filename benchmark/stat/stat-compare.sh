node_binary=node

set -e

iterations=1000000

echo "Statting '.' $iterations times"

echo
echo "Native timings:"

gcc -O1 -o native-stat -xc - <<EOF
#include <sys/stat.h>

int main(int argc, char **argv) {
    struct stat fileStat;
    int i;
    for (i = 0; i < $iterations; i++) {
        if (stat(".", &fileStat) < 0) {
            return 1;
        }
    }
    return 0;
}
EOF

time ./native-stat
rm native-stat

echo
echo "Node timings (Node $($node_binary --version)):"

time $node_binary <<EOF
var fs = require('fs')

for (var i = 0; i < $iterations; i++) {
  fs.statSync('.')
}
EOF
