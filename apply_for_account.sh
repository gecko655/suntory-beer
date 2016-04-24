for line in `cat $1`
do
  export $line
done

ruby suntory-beer.rb
