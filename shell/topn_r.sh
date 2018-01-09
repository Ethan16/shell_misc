#!/bin/bash

end=$1

cat $2 |
tr -cs "[a-z][A-Z]" "[\012*]" |    #\012是换行符的八进制码
  tr A-Z a-z |
    sort |
	  uniq -c |
	    sort -k1nr -k2 |
		  head -n"$end"