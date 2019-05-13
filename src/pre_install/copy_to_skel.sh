#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

copy_to_skel() {

    declare -a FILES_TO_COPY=(

        "files/bash/bash_aliases"
        "files/bash/bash_autocomplete"
        "files/bash/bash_exports"
        "files/bash/bash_functions"
        "files/bash/bash_logout"
        "files/bash/bash_options"
        "files/bash/bash_profile"
        "files/bash/bash_prompt"
        "files/bash/bashrc"
        "files/bash/curlrc"
        "files/bash/inputrc"

        "files/git/gitattributes"
        "files/git/gitconfig"
        "files/git/gitignore"

    )

    local i=""
    local sourceFile=""
    local targetFile=""
    local skipQuestions=false

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="/etc/skel/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ ! -e "$targetFile" ] || $skipQuestions; then

            execute \
                "cp $sourceFile $targetFile" \
                "$targetFile → $sourceFile"

        else

            if ! $skipQuestions; then

                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then

                    rm -rf "$targetFile"

                    execute \
                        "cp $sourceFile $targetFile" \
                        "$targetFile → $sourceFile"

                else
                    print_error "$targetFile → $sourceFile"
                fi

            fi

        fi

    done

}

main() {
    print_in_purple "\n • Copy config files to /etc/skel \n\n"
    copy_to_skel "$@"
}

main "$@"
