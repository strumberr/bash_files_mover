#!/bin/bash

usage() {
    echo -e "\033[0;33mUsage: $0 <directory> [-e/--extension <extension> <subdirectory>]\033[0m"
    echo -e "\033[0;33mor\033[0m"
    echo -e "\033[0;33mUsage: $0 <directory>\033[0m"
    echo ""
    echo -e "\033[0;33mOptions:\033[0m"
    echo -e "\033[0;33m  -i                  Enable interactive mode\033[0m"
    echo -e "\033[0;33m  --help              Show help information\033[0m"
    echo -e "\033[0;33m  -e, --extension     Specify custom file extension and subdirectory\033[0m"
    echo -e "\033[0;33m  -a                  To move all known extensions\033[0m"
    echo ""
    echo -e "\033[0;33mExamples:\033[0m"
    echo -e "\033[0;33m  $0 /path/to/directory\033[0m"
    echo -e "\033[0;33m  $0 /path/to/directory -e txt text_files\033[0m"
    echo -e "\033[0;33m  $0 /path/to/directory -i\033[0m"
    echo ""
    exit 1
}

file_organizer_all() {
    local file_extension=$1
    local subdir=$2

    if [ -e *."$file_extension" ]; then
        mkdir -p "$subdir"
        mv *."$file_extension" "$subdir"

        if [ $? -eq 0 ]; then
            echo -e "\033[0;32mFiles with extension .$file_extension moved to $subdir:\033[0m"
            ls "$subdir"
        else
            echo -e "\033[0;31mFailed to move files with extension .$file_extension to $subdir\033[0m"
        fi
    else
        echo -e "\033[0;31mNo files with extension .$file_extension found\033[0m"
        return 1
    fi
}

file_organizer() {
    local file_extension=$1
    local subdir=$2

    mkdir -p "$subdir"
    mv *."$file_extension" "$subdir"

    if [ $? -eq 0 ]; then
        echo -e "\033[0;32mFiles with extension .$file_extension moved to $subdir:\033[0m"
        ls "$subdir"
    else
        echo -e "\033[0;31mNo files with extension .$file_extension found\033[0m"
    fi
}

file_organizer_interactive() {
    local file_extension=$1
    local subdir=$2
    echo -e "\033[0;34mDo you want to move files with extension .$file_extension to $subdir? [y/n]\033[0m"
    read answer

    if [ "$answer" != "${answer#[Yy]}" ]; then
        

        mkdir -p "$subdir"
        mv *."$file_extension" "$subdir" 2>/dev/null

        if [ $? -eq 0 ]; then
            echo -e "\033[0;32mFiles with extension .$file_extension moved to $subdir:\033[0m"
            ls "$subdir"
        else
            echo -e "\033[0;31mNo files with extension .$file_extension found\033[0m"
        fi
    fi
}

if [ "$#" -lt 1 ]; then
    usage
    exit 1
fi

interactive=false
move_all=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -a)
            move_all=true
            shift
            ;;
        -i)
            interactive=true
            shift
            ;;

        --help)
            usage
            exit 0
            ;;
        -e|--extension)
            shift
            custom_extension=$1
            shift
            custom_subdir=$1
            shift
            ;;
        *)
            directory=$1
            shift
            ;;
    esac
done

cd "$directory" || { echo -e "\033[0;31mCouldn't find the directory!: $directory\033[0m"; usage; exit 1; }

if [ "$move_all" = true ]; then
    file_organizer_all "doc" "documents"
    file_organizer_all "png" "images"
    file_organizer_all "sh" "scripts"
    file_organizer_all "txt" "text_files"
    file_organizer_all "pdf" "pdfs"
    file_organizer_all "mp3" "music"
    file_organizer_all "mp4" "videos"
    file_organizer_all "zip" "archives"
    file_organizer_all "deb" "deb_packages"
    file_organizer_all "exe" "executables"
    file_organizer_all "csv" "csv_files"
    file_organizer_all "json" "json_files"
    file_organizer_all "xml" "xml_files"
    file_organizer_all "html" "html_files"
    file_organizer_all "css" "css_files"
    file_organizer_all "js" "js_files"
    file_organizer_all "py" "python_files"
    file_organizer_all "c" "c_files"
    file_organizer_all "cpp" "cpp_files"
    file_organizer_all "java" "java_files"
    file_organizer_all "class" "class_files"
    file_organizer_all "sql" "sql_files"
    file_organizer_all "php" "php_files"
    file_organizer_all "md" "markdown_files"
    file_organizer_all "svg" "svg_files"
    file_organizer_all "gif" "gif_files"
    file_organizer_all "jpg" "jpg_files"
    file_organizer_all "jpeg" "jpeg_files"
    file_organizer_all "ico" "ico_files"
    file_organizer_all "eps" "eps_files"
    file_organizer_all "tiff" "tiff_files"
    file_organizer_all "raw" "raw_files"
    file_organizer_all "mpg" "mpg_files"
    file_organizer_all "mpeg" "mpeg_files"
    file_organizer_all "avi" "avi_files"
    file_organizer_all "mov" "mov_files"
    file_organizer_all "wav" "wav_files"
    file_organizer_all "aac" "aac_files"
    file_organizer_all "wma" "wma_files"
    file_organizer_all "ogg" "ogg_files"
    file_organizer_all "flac" "flac_files"
    file_organizer_all "m4a" "m4a_files"
    file_organizer_all "rar" "rar_files"
    file_organizer_all "tar" "tar_files"
    file_organizer_all "gz" "gz_files"

else
    if [ ! -z "$custom_extension" ] && [ ! -z "$custom_subdir" ]; then
        if [ "$interactive" = true ]; then
            file_organizer_interactive "$custom_extension" "$custom_subdir"
        else
            file_organizer "$custom_extension" "$custom_subdir"
        fi
    else
        if [ "$interactive" = true ]; then
            file_organizer_interactive "doc" "documents"
            file_organizer_interactive "png" "images"
            file_organizer_interactive "sh" "scripts"
        else
            file_organizer "doc" "documents"
            file_organizer "png" "images"
            file_organizer "sh" "scripts"
        fi

    fi
fi

echo "Organized files in $directory"
