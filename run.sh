info="Commit: $(date)"
echo "OS detected: $OSTYPE"

case "$OSTYPE" in
    darwin*)
        cd "`dirname $0`" || { echo "Failed to change directory"; exit 1; }
        ;;

    linux*)
        cd "$(dirname "$(readlink -f "$0")")" || { echo "Failed to change directory"; exit 1; }
        ;;

    *)
        echo "OS unsupported (submit an issue on GitHub!)"
        exit 1
        ;;
esac

echo "$info" >> output.txt
if [ $? -ne 0 ]; then
    echo "Failed to write to output.txt"
    exit 1
fi

echo "$info"
echo

# Ship it
git add output.txt
if [ $? -ne 0 ]; then
    echo "Failed to add changes"
    exit 1
fi

git commit -m "$info"
if [ $? -ne 0 ]; then
    echo "Failed to commit changes"
    exit 1
fi

git push -f https://kalpakci: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@github.com/kalpakci/commit-bot.git main
if [ $? -ne 0 ]; then
    echo "Failed to push to origin"
    exit 1
fi

cd -
