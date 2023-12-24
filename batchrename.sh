#!/bin/bash

# Перевірка правильності введених аргументів
if [ "$#" -ne 3 ]; then
    echo "Потрібно ввести 3 аргументи: каталог, оригінальне розширення та нове розширення"
    exit 1
fi

# Зберігаємо аргументи в змінні
directory="$1"
original_extension="$2"
new_extension="$3"

# Перейти в каталог
cd "$directory" || exit 1

# Перебір файлів у каталозі з вказаним розширенням
for file in *."$original_extension"; do
    # Формуємо нове ім'я файлу з новим розширенням
    new_file="${file%.$original_extension}.$new_extension"
    
    # Виводимо повідомлення про перейменування
    echo "Переіменовую $file на $new_file"
done

# Підраховуємо кількість файлів у директорії, які мають нове розширення
count=$(ls -lAh | grep ".$new_extension" | wc -l)

# Виводимо кількість файлів
echo "Кількість файлів у директорії, які містять .$new_extension: $count"

