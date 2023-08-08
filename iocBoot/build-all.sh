## Build All Hutch IOCs ##

Green='\033[0;32m'
NC='\033[0m'


for d in */ ;
do
  echo -e "${Green} Building $d${NC}\n"
  (cd "$d" && make)
done


