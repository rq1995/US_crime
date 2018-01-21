#! /bin/bash

# cookie cutter bash shell script
# Ruoqi Xu, 2017-11-17
# Reference:https://github.com/chendaniely/computational-project-cookie-cutter/blob/master/setup_project_dir.sh
# This script can generates a project file and directory structure template.
#
# Arguement: The argument passed into the script should be the dir
# where you want the project folder structure setup.
# Output: create the following folder structure

cd $1
touch CITATION.md
touch README.md
touch LICENSE.md
mkdir doc data src from_partner results

cd doc
echo "Doc directory include notebooks and manuscripts" > README.md
touch .gitkeep

cd ../data
echo "Data directory for storing fixed data sets" > README.md
touch .gitkeep

cd ../src
echo "src for source code" > README.md
touch .gitkeep

cd ../from_partner
echo "from_partner include origin scripts from partners" > README.md
touch .gitkeep

cd ../results
echo "Results directory for result report" > README.md
touch .gitkeep

cd ..

echo "
# cookie cutter bash shell script
# Ruoqi Xu, 2017-11-17
# Reference:https://github.com/chendaniely/computational-project-cookie-cutter/blob/master/setup_project_dir.sh
# This script can generates a project file and directory structure template.
#
# Arguement: The argument passed into the script should be the dir
# where you want the project folder structure setup.
# Output: create the following folder structure
# Path_Provided
    |- CITATION.md
    |
    |- README.md
    |
    |- LICENSE.md
    |
    |- doc/           # directory for documentation, one subdirectory for manuscript
    |
    |- data/          # data for storing fixed data sets
    |
    |- src/           # any source code
    |
    |- from_partner/           # any compiled binaries or scripts
    |
    |- results/       # output for tracking computational experiments performed on data
" > README.md
