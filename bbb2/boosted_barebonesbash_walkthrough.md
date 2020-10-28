# Boosted (Bespoke)BareBonesBash(BroughtByBlissfullyBaffledBioinformaticians)

A basic Bash tutorial by [James A. Fellows Yates (@jfy133)](https://github.com/jfy133), [Thiseas C. Lamnidis (@TCLamnidis)](https://github.com/TCLamnidis) and [Aida Andrades Valtueña (@aidaanva)](https://github.com/aidaanva).

<p align="center">
<img title="Source: https://giphy.com/gifs/v58q1se3dZvag" src="https://media.giphy.com/media/3o7TKtVHfLeAWCTuh2/giphy.gif" width="40%"></p>

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><p align="center"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

🛠️ **UNDER CONSTRUCTION!** 🛠️

## Table of contents

<!-- TO INSERT WITH VSCODE -->

## Introduction

The aim of this tutorial is to advance your knowledge gained from [Basic BareBonesBash](https://barebonesbash.github.io/#/bbb1/README). Basic BBB introduced fundamental concepts on how to do basic navigation _[Thiseas still insists on that fancy word...]_, moving and reading files, and generating basic information statistics on these files. In this session, we will focus on more realistic/'useful' scenarios when it comes to the command line. We will be covering ways of speeding up and automating tasks using more 'abstract' but very common computing concepts. However, don't worry! We will be taking it slowly and gently, and of course, full of GIFs!

## tl;dr

If you want to know what you will learn in this tutorial, or are already too scared to read the rest of this tutorial, you can look at this table as a quick reference. To understand actually what each command does, carry on reading below!

| command    | description                                           | example                     | common flags or arguments                                          |
|------------|-------------------------------------------------------|-----------------------------|--------------------------------------------------------------------|
| `find`     | search for files or directories                       | `find -name 'pen'`          | -type f (search only for files)<br> -name '*JPG' (search for file names matching the pattern)         | 
| `"$var"`   | use double quotes to use contents of variable         | `pen=apple && echo "$pen"` |                                                                    |
| `rev`      | reverse the order of characters in a string               | `rev 'pineapple'`           |                                                                    |
| `cut`      | separate each line of a file into multiple pieces        | `cut -f ' ' -d`             | -f(ield, i.e piece to keep), -d(elimiter, which char. to split by) |
| `$()` | runs the command in parentheses and interprets its output as a string | `num_lines=$(wc -l my_file.txt | cut -f 1)` |
`${var}` | parameter expansion of variables | `echo ${pen#app}`<br>`echo ${pen%le}`<br>`echo ${pen/le/lication}` | `#`/`##` removes charcters from the start of the variable<br>`%`/`%%` removes characters from the end of a variable <br>`/X/Y` substitute string "X" in the variable for "Y". If Y is omitted, removes string X
`${#var}` | get the length of the contents of a variable | `echo ${#pen}` |
`rename` | apply a regex to the name of files to rename them | `rename 's/\.JPG$/.jpg/' *` | 
`<`<br>`>`<br>`2>` | redirects the standard input/output/error stream respectively into a file | `cat <file.txt >file_copy.txt 2>cat_file.err` |
`basename` |  gives you the file name, removing the path | `basename /path/to/my/file.txt` | 
`dirname` | gives you the path to a file, removing the filename | `dirname /path/to/my/file.txt` | 
`while` | begins 'while' loop, requires a condition, 'do' and 'done' | `while [[ "${pen}" == "apple" ]]; do echo "penpineapple${pen}pen"` | 
`[[`<br>`((` | conditions of conditionals. <br> `!` is a NOT<br>`||` is an OR <br> `&&` is an AND | `[[ ${pen} == "apple" ]]` <br> `(( 7 - 3 == 4 ))` | `-f` check if file exists <br> `-n` check if variable is set
`read` | takes the contents of the file and loads them into a specified variable. Often used with _while_ loops. | `while read line; do echo ${line}; done <file.txt`
`paste` | Pastes lines of multiple files side-by-side | `paste file1.txt file2.txt`| `-` can be used to refer to `stdin` 
`sed` | edits the contents of a file on the fly | `sed 's/A/dog/' Annotations.txt` | -e(xpression) can be provided multiple times to specify multiple expressions. <br> -i(n place)
`if` | begins conditional. Requires a condition, `then` and ends with `fi` | `if [[ ${pen} == "apple" ]]; then`<br>`echo "${pen}"`<br>`fi` | 
`#!`|  a shebang. used in scripts to make them executable | `#! /usr/bin/env bash` 
`${1}`<br>`${2}`<br>`${3}`<br>... | positional arguments of a script | `$ ./myscript.sh pen pineapple apple`<br> `echo ${1}${2}${3}${1}` |

### Regex basics
| expression    | meaning                                           | example                     |
|---------------|---------------------------------------------------|-----------------------------|
`.` | match any character | `grep '.ear' regex.txt`
`*` | match 0 or more of the preceding items | `grep 'be*r' regex.txt`
`\` | do not interpret next character | `grep 'be\*r' regex.txt`<br> (`*` is interpreted as an asterisk character)
`\?` | match 0 or 1 of the preceding items | `grep 'be\?r' regex.txt`
`\+` | match 1 or more of the preceding items | `grep 'be\+r' regex.txt`
`[]` | match range of characters within [] | `grep 'p[iea]r' regex.txt`
`[^]` | match range of characters except the ones in the bracket | `grep 'p[^iea]r' regex.txt`
`^` | the beginning of the line | `grep '^[rb]\+' regex.txt`
`$` | the end of the line | `grep 'r$' regex.txt`

## Where is my stuff??
The first thing that you have to do is to know where the directories/files that you want to work with are. So, how can you search for files and directories hidden in layers and layers of (your very organised) directories?

For this task, you can use the command `find`

Let's see how this command works with an example:

`find Boosted-BBB/ -type f -name '*JPG'`

The **first** part of the `find` command indicates **the place from which to start looking**, in the example above the directory `Boosted-BBB`. You can also specify:
- `.` to look in here (the current directory)
- `~/` to look in your home directory
- Absolute path (i.e.`/home/james`). Note: This will print the absolute path and the found file/directory, it is usefull when you want to use the output of `find`

*Keep in mind that it will look in the directory specified and all of its subdirectories unless indicated otherwise.*

The **second** part of the `find` command indicates **what type of things you are looking for**

- Use `-type` to define the file type

    - **f**ile
    - **d**irectory

In the example we are looking for files (`-type f`)

The **third** part of the `find` command is **what to look in**

- Use `-name` to say 'look in the *names* of things'
    - After the flag you will indicate the 'strings' to search for
    - You can use wildcards (\*) for maximum laziness! 

In the example above, we look for files that contain `JPG` in some part of their name (`'*JPG*'`).

Check what the output of the find command is by running it:

`find Boosted-BBB/ -type f -name '*JPG'`

You can also store the string we are looking for in a variable, so you can change it for another easily in the future (This will be useful when creating scripts, which we will cover later in the session). To do so, let's store our string `JPG` in a variable:

`suffix="JPG"`

Let's try now to call the variable in our find command as:

`find Boosted-BBB -type f -name '*$suffix'`

It did not find any of the files! But we know the files do exist. Let's try the following command:

`find Boosted-BBB -type f -name "*$suffix"`

Ta-da! It found your files, what is the difference between these commands??

That's right! The quotes!

## Concept: Quotes matter!
Which quotes you use plays an important role in how bash understand the message within them:
* Single quotes: the content is passed on as it is written
* Double quotes: the content is interpreted

In some cases, the way you write the statments does not matter, as in the following example:
```
echo "I like Greek Food"
echo 'I like Greek Food'
```
This two statements will result in the same (universally true) printed message:

`I like Greek Food`

`I like Greek Food`

Now let's consider the following example:
```
Arr=Banana
echo 'Pirates say $Arr'
echo "Minions say $Arr"
```
Here, the results are different:

`Pirates say $Arr`

`Minions say Banana`

As you can see in the case of single quotes, bash does not interpret the variable `$Arr` as Banana, since it is not being translated by the computer to the correct meaning. In the case of the double quotes, the program understands `$Arr` as a variable, and interprets it to mean the string `"Banana"`. 

Now let's continue with your files

## Cleaning up the filenames

So... you found your files, but it seems that wherever you got the files from has completely mangled the file names (What is with this weird file extention `.JPG.MP3.TXT`???)

You know that these files are supposed to be images with the extension `.JPG`. So let's clean up the file names, and then you can sort them into categories. 

There are different ways to tackle this problem. First, we will show you an example that uses `cut` and `rev`.

Can you guess what these commands do?

* `rev`: reverses a character string
* `cut`: cuts a string into multiple pieces

Let's try them out!
```
echo "aBcDeF 654321" | rev
```

It results in:

`123456 FeDcBa`

Now let's see how `cut` work. This command needs some options to know how to deal with the string. Those are:
* `-d` speficies the field *d*elimiter we are using. Here it is space (" ").
* `-f` specifies which *f*ield we wish to cut out. We want to recover the numbers so this will be the second field.
> For more options, check the `man` page!

Let's write the command to obtain the number then:

```
echo "aBcDeF 654321" | cut -d " " -f 2
```
And the result is:

`654321`

So let's combine them to clean up our file names. You will use a `for` loop to change all the file names you have found with the `find` command to the desired ending (filename containing only the `.JPG` extension)

The `for` look will look like this:

```
suffix=JPG
for file in $(find Boosted-BBB/ -type f -name "*$suffix*"); do
>    new_name=$(echo $file | rev | cut -d "." -f 2-999 | rev)
>    echo $file $new_name
>    #mv $file $new_name
> done
```

You should use `echo` to make a 'dry-run', meaning that you can try your code without making any changes. When you are happy with the output from the echo command, uncomment the `mv` command and re-run the `for` loop to change the name of the file for the `$new_name`.

**This code is cumbersome to write, read and understand.**

### Wait, what just happened? 
# Thiseas checked till here!!! 

Let's break the code in parts to understand what is going on:
* `for file in $(find Boosted-BBB/ -type f -name "*$suffix*"); do`: this starts the for loop. The `$()` tells bash to put the output of the `find` command as a list, that the `for` loop will look through. 
* `new_name=$(echo $file | rev | cut -d "." -f 2-999 | rev)`: `$()` tells bash to run the commands within parenthesis and interpret the output as a string. The string is then assigned to the `new_name` variable
    * `echo $file`: print the filepath:
    
    `~/boosted_barebonesbash/Boosted-BBB/Friday/night/and/the/lights/are/low/fanta.JPG.MP3.TX`
    
    * `rev`: it `rev`erse the file name:
    `TXT.3PM.GPJ.atnaf/wol/era/sthgil/eht/dna/thgin/yadirF/BBB-detsooB/hsabsenoberab_detsoob/~`
    * `cut -d "." -f 2-999`: it `cut` the string at each "." (the `-d`elimiter) and keeps everything adter the first delimiter (`-f`ields `2-999`):
 `3PM.GPJ.atnaf/wol/era/sthgil/eht/dna/thgin/yadirF/BBB-detsooB/hsabsenoberab_detsoob/~`
    * `rev`: it `rev`erse to the original file name: 
    `~/boosted_barebonesbash/Boosted-BBB/Friday/night/and/the/lights/are/low/fanta.JPG.MP3`
    * Finally, we rename the file to the new name with `mv`
    
### Writing pretty code
The code we just saw was long and unnecessary. It is a good idea to avoid cluncky code. How can we then simply this code:
```
suffix=JPG
for file in $(find Boosted-BBB/ -type f -name "*$suffix*"); do
>    new_name=$(echo $file | rev | cut -d "." -f 2-999 | rev)
>    echo $file $new_name
>    #mv $file $new_name
> done
```
We can shortern it by employing bash **parameter expansion** (the magic!)

## Parameter expansion: The basics
Parameter expansion is a method in-build in bash that allows you to manipulate variables. Let's explore some examples.
Given the variable:

```
foo="/home/thiseas/folder/subfolder/BBB.is.bae.txt"
```

You can expand a variable by using `${}`, as:
```
echo ${foo}
```
Will result into bash printing our variable:
`
/home/thiseas/folder/subfolder/BBB.is.bae.txt
`
### Some parameters for expansion

As mentioned, bash expansion allows for the manipulation of variables. For doing that, you can also add a parameter to expansions. Here are some examples:
* `#string`: removed the string starting from the left side of the variable
    ```
    echo ${foo#/home/}
    ```
    `thiseas/folder/subfolder/BBB.is.bae.txt`
    
* `%string`: removes the string starting from the right side of the variable
    ```
    echo ${foo%.txt}
    ```
    `/home/thiseas/folder/subfolder/BBB.is.bae`
You can use wildcards within this parameters as in the following examples:
```
foo="/home/thiseas/folder/subfolder/BBB.is.bae.txt"

echo ${foo}    # No parameters in this expansion
echo ${foo#*/} # Removes everything before the first '/'
echo ${foo%.*} # What will this do?
```
Results in:
`
/home/thiseas/folder/subfolder/BBB.is.bae.txt
home/thiseas/folder/subfolder/BBB.is.bae.txt
/home/thiseas/folder/subfolder/BBB.is.bae
`

Additionally, these expansions can be generalised as follows:

```
echo ${foo##*/} # Removes everything before any '/'
echo ${foo%%.*} # Removes everything after any '.'
```

`
BBB.is.bae.txt
`

`
/home/thiseas/folder/subfolder/BBB
`

### More parameters for expansion
Other than removing parts of the variable, we can also modify the variable:
* `/string/string`: substitutes the first string by the second string in the variable

```
foo="/home/thiseas/folder/subfolder/BBB.is.bae.txt"
echo ${foo}                    # No parameters
echo ${foo/BBB/BareBonesBash}  # Change BBB to BareBonesBash
```

`
/home/thiseas/folder/subfolder/BBB.is.bae.txt
/home/thiseas/folder/subfolder/BareBonesBash.is.bae.txt
`

*  `/string/`: substitutes the string by an empty string

```
echo ${foo/BBB}  # Remove BBB
```
`
/home/thiseas/folder/subfolder/.is.bae.txt
`

### The last parameter, I swear!

Finally, you can check the length of a variable (how many characters the variable has) by using a # BEFORE the variable name.

``` foo="/home/thiseas/folder/subfolder/BBB.is.bae.txt"
echo ${#foo}  # The length of the variable contents
```
`45`

So the filepath in foo is 45 characters long!

This parameter will become more handy when when dealing with bash arrays (i.e. lists of things).

## Writing pretty code
We can now rewrite our complicated and convoluted code using `rev` and `cut`. DO NOT RUN THIS CODE!

```
for file in $(find Boosted-BBB/ -type f -name "*$suffix*"); do
   new_name=$(echo $file | rev | cut -d "." -f 2-999 | rev)
   echo $file $new_name
   # mv $file $new_name
done
```
To this:
```
for file in $(find Boosted-BBB/ -type f -name "*JPG*"); do
   echo ${file} ${file%.*}
   # mv ${file} ${file%.*}
done
```

Try running both codes using only the printing command `echo` before modifying the actual variable (dry-running) and check that the result is the same! Is there a difference in runtime?

Result: 0.051s versus 0.003s when running `echo`!

When you are sure it works, remove the comment in the 2nd codeblock to rename the files!

## Almost done!
We now have all the files named similarly, but some things are still a bit off. The file suffix JPG is conventionally written in lowercase characters (jpg).

So, let's change all filename suffixes to be in lowercase letters!

This operation can be done with parameter expansion, but we can use regular expressions to do this without a for loop.

Regex is an important concept that you encounter in most programming languages.

The actual syntax may vary from language to language, but the concept is the same. We will show here's how they work in bash.

## Concept: Regular expressions
Regex are special strings and characters that define a 'search pattern'. They are normally used in 'Search' or 'Search/Replace' functions e.g. in excel! And: **You have already used them!**


Three regex special character 'categories' that must be kept in mind:

* `.`, `*`, `^`, `$` (etc.): special characters that are translated to regex function first. You can stop bash translating those by typing `\` before them, this will find the literal symbol)
* `\t`, `\w`, `\D` (etc.): letter-based special characters that must have \ to be 'translated'
* `[]`, `()`, (etc.): range, grouping, or 'capturing' matching regex within brackets

We will showcase them by applying some search function in a file. For this, download the following file
```
wget git.io/Boosted-BBB-regex
mv Boosted-BBB-regex regex.txt
```
Let's also look at the contents.

```
cat regex.txt
```
Now let's see which 'parameters' we can use to try to find different words using grep:

* `.` : match any character. Let's find strings containing: "any character + ear"

```
grep '.ear' regex.txt
```

* []: match range of characters within
* [^]: match range of characters except the ones in the bracket
* *: match 0 or more of the preceding items
* \: do not interpret next character
* \+: match 1 or more of the preceding items
* \?: match 0 or 1 of the preceding items
* ^: the beginning of the line
* $: the end of the line