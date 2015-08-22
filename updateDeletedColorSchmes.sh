#!/bin/bash

case $* in
    *)
    # create)
        # move to a separate file -> create_lists
        # tar tf vimCSscreenshots.tgz > allColorSchemes.list
        ls -1 *[^1].png > notDeleted.list
        comm -13 notDeleted.list allColorSchemes.list > Deleted.list
        cp Deleted.list ~/.vim/bundle/vim-colorschemes/colors/
        # SORT BY BRIGHTNESS
        # for i in *.png
        # do
        #     convert  $i  -colorspace hsb  -resize 1x1  txt:- | grep '%' | awk -F, '{print "'$i'",substr($NF,0,2)}'
        # done > seprateByBrightness.list
        # column -t seprateByBrightness.list | sort -nr -k2 | cut -d ' ' -f 1 > sortedByBrightness.list
        # sed -n '1,/tabula/ p' sortedByBrightness.list > lighter.list
        # sed '1,/tabula/ d' sortedByBrightness.list > darker.list
        echo "del list cre4ated"
        # ;;
    # both)
        # move to a separate file -> deleteBadColorschemes, check for existance of all files
        echo "both"
        cd ~/.vim/bundle/vim-colorschemes/colors/
        git reset HEAD --hard
        for i in `cat Deleted.list| sed 's/.png$/.vim/'`
        do
            rm $i
        done
        ;;
    crop)
        # crop screenshots to reamove
        for i in `ls *.png`
        do
            convert -crop 1915x1044+1+18 $i $i
        done
        ;;
esac
