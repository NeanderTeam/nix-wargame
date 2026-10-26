# EXPECT-SUCCESS: a wrong input still yields a (different, non-matching) flag-shaped string.
# Fake version line: the flag depends on the real pinned `hello`; guessing a version must fail.
echo "hello (GNU Hello) 0.0" | ./check.sh
