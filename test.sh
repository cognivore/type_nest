output=$(mix dialyzer 2>&1)
bugs=$(grep " # bug" ./lib/etypes.ex | wc -l)
outcome=$(echo "$output" | grep "Total errors: $bugs")

[ ! -z "$outcome" ] && echo "Success." && exit 0

echo "$output"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "Bug mismatch! ./lib/etypes.ex expected $bugs bugs."
echo "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
grep bug -a2 ./lib/etypes.ex
exit -1
