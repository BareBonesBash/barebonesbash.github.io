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
`read` | takes the contents of the file and loads them into a specified variable. Often used with _while_ loops. | `while read line; do echo ${line}; done <file.txt`
`paste` | Pastes lines of multiple files side-by-side | `paste file1.txt file2.txt `| `-` can be used to refer to `stdin` 
`sed` | edits the contents of a file on the fly | `sed 's/A/dog/' Annotations.txt` | -e(xpression) can be provided multiple times to specify multiple expressions

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
The first thing that one have to do is to know where are the directories/files that you want to work. So, how can one search for files and directories hidden in layers or layers (of one's very organised) directories?

For this task, you can use the command `find`

Let's see how this command works with an example:

`find Boosted-BBB/ -type f -name '*JPG'`

The **first** of the `find` command indicates **the place from which will start looking for**, in the example the directory `Boosted-BBB`. You can also specify:
- `.` to look in here
- `~/` to look in your home directory
- Absolute path (i.e.`/home/james`). Note: This will print the absolute path and the found file/directory, it is usefull when you want to use the output of `find`

*Keep in mind that it will look in the directory specified and all of the directories that it contains unless indicated otherwise.*

The **second** part of the `find` command indicates **what type of things you are looking for**

- Use `-type` to define the file type

    - **f**ile
    - **d**irectory

In the example we are looking for files (`-type f`)

The **third** part of the `find` command is **what to look in**

- Use `-name` to say'look in the *names* of things'
    - After the flag you will indicate the 'strings' to search for
    - You can use wildcards (\*) for maximum laziness! 

As in our example where we look for files that contain in some part of the string *JPG* (`'*JPG*'`).

Check what the output of the find command is by running it:

`find Boosted-BBB/ -type f -name '*JPG'`

We can also store the string we are looking for in a variable, so we can change it for another easily in the future (This will be useful when creating scripts, which we will cover later in the session). To do so, let's store our string `JPG` in a variable:

`suffix="JPG"`

Let's try now to call the variable in our find command as:

`find Boosted-BBB -type f -name '*$suffix'`

We did not find any of the files! But we know the files do exist. Let's try the following command:

`find Boosted-BBB -type f -name "*$suffix"`

Tada! It found our files, what did it change between this commands??

That's right the quotes!

## Concept: Quotes matter!
How quotes are written play an important role in how bash understand the message within them:
* Single quotes: the content is passed on as it is written
* Double quotes: the content is interpreted

In some cases, the way we write the statments does not matter, as in the following example:
```
echo "I like Greek Food"
echo 'I like Greek Food'
```
This two statements will result in the same printed message:

`I like Greek Food`

`I like Greek Food`

Now let's consider the following example:
```
Arr=Banana
echo 'Pirates say $Arr'
echo "Minions say $Arr"
```
it will result in:

`Pirates say $Arr`

`Minions say Banana`

As you can see in the case of single quotes, bash does not interprete the variable `$Arr` as Banana, since it is not being translated by the computer to the correct meaning. In the case of the double quotes, the program understands `$Arr` as a varible containing the string Banana. 

Now let's continue with our files

## Cleaning up the filenames

So... we found our files, but it seems that wherever we got the files from have completely mangled the file names (What is the weird file extention `.JPG.MP3.TXT`???)

We know that this files are supposed to be images with the extension `.JPG`. So let's clean up the file names, and then we can sort them into categories. 

There is different ways to tackle this problem, so we will fist show an example that uses `cut` and `rev`.

Can you guess that this commands do?

* `rev`: reverses a character string
* `cut`: cuts a string into multiple pieces

Let's try them out!
```
echo "aBcDeF 654321" | rev
```

It results in:

`123456 FeDcBa`

Now let's see how `cut` work. This command needs some arguments to know how to deal with the string. Those are:
* `-d` speficies the field *d*elimiter we are using. Here it is space (" ").
* `-f` specifies which *f*ield we wish to cut out. We want to recover the numbers so this will be the second field.

Let's write the command to obtain the number then:

```
echo "aBcDeF 654321" | cut -d " " -f 2
```
And the result is:

`654321`

So let's combine them to clean up our file names. We will use a `for` look to change all the file names we have found with the `find` command to the desired ending (filename containing only the `.JPG` extension)

The `for` look will look like:

```
suffix=JPG
for file in $(find Boosted-BBB/ -type f -name "*$suffix*"); do
>    new_name=$(echo $file | rev | cut -d "." -f 2-999 | rev)
>    echo $file $new_name
>    #mv $file $new_name
> done
```

We use `echo` to make a 'dry-run', meaning that you can try your code without making any changes. When you are happy with the output from the echo command, uncomment the `mv` command and re-run the `for` loop to change the name of the file for the `$new_name`.

**BUT WAIT! This code is cumbersome to write, read and understand.**

### Wait, what just happened?

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
