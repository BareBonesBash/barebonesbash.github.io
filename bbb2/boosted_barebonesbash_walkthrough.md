# Boosted (Bespoke)BareBonesBash(BroughtByBlissfullyBaffledBioinformaticians)

A basic Bash tutorial by [James A. Fellows Yates (@jfy133)](https://github.com/jfy133), [Thiseas C. Lamnidis (@TCLamnidis)](https://github.com/TCLamnidis) and [Aida Andrades Valtueña (@aidaanva)](https://github.com/aidaanva).
<p align="center"><img title="Source: https://giphy.com/gifs/v58q1se3dZvag" src="https://media.giphy.com/media/3o7TKtVHfLeAWCTuh2/giphy.gif" width="40%"></p>

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><p align="center"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

🛠️ **UNDER CONSTRUCTION!** 🛠️

## Table of contents

<!-- TO INSERT WITH VSCODE -->

## Introduction

James iz secksi  :heart_decoration: :eggplant: :sweat_drops: 

The aim of this tutorial is to advance your knowledge gained from [Basic BareBonesBash](https://barebonesbash.github.io/#/bbb1/README). Basic BBB introduced fundamental concepts on how to do basic navigation _[Thiseas still insists on that fancy word...]_, moving and read files, and generating basic information statistics on thse files. In this session, we will focus on more realistic 'useful' scenarios when it comes to the command line. We will be covering ways of speeding up and automating tasks using more 'abstract' but very common computing concepts. However, don't worry! We will be taking it slowly and gently, and of course, full of GIFs!

## tl;dr

If you want to know what you will learn in this tutorial, or are already too scared to read the rest of this tutorial, you can look at this table as a quick reference. To understand actually what each command does, carry on reading below!

| command | description | example | common flags or arguments |
|---------|-------------|---------|---------------------------|
|         |             |         |                           |



<!-- DO NOT EDIT BELOW THIS IS FOR HACKMD DARKMODE -->

<style>

/* Dark mode */

:root{
    --white-text: #ddd;
    --white-gray-text: #bbb;
    --black-text: #333;
    --gray-text: #666;
    --navbar-background: #242424;
    --navbar-alt-background: #363636;
    --gray-background: #23272a;
    --darkblue-background: #40788A;
    --darkblue-alt-background: #2c5460;
    --link-text: #339fff;
    --link-hover-text: #2d6da4;
}

body,
.ui-comment-container .ui-comments-container {
    background-color: var(--gray-background) !important;
}

a{
    color: var(--link-text);
}
a:hover,
a:active{
    color: var(--link-hover-text);
}
.navbar-default,
.navbar-default * label,
.navbar-default * span,
.ui-comment-container .ui-comment-header,
.ui-comment-container .ui-comment-input-container{
    background-color: var(--navbar-background);
    color: var(--white-text);
    border-color: var(--gray-text);
}

.modal-dialog * .modal-body{
    
    background-color: var(--navbar-background) !important;
    color: var(--white-text) !important;
}
.ui-notification-label{
    color: var(--white-text) !important;
    background-color: var(--darkblue-background);
    border-color: var(--darkblue-alt-background) !important;
}
.ui-notification-label:hover,
.ui-notification-label:active,
.ui-notification-label:focus{
    background-color: var(--darkblue-alt-background);
}

.navbar-default .announcement-popover * ,
.modal-dialog * .modal-header,
.modal-dialog * .modal-footer,
.panel > .panel-heading,
.panel-body{
    background-color: var(--gray-background) !important;
    color: var(--white-text) !important;
}

.dropdown-menu,
.dropdown-menu>li>a{
    background-color: var(--gray-background) ;
    color: var(--white-text);
}

.markdown-body,
.ui-toc-dropdown .nav > .active > a,
.ui-comment-container .comment-blank-stats,
.markdown-body h1 .octicon-link,
.markdown-body h2 .octicon-link,
.markdown-body h3 .octicon-link,
.markdown-body h4 .octicon-link{
    color: var(--white-text);
}
.ui-toc-dropdown .nav > .active > a:hover{
    color: var(--gray-text);
}

.ui-lastchange,
.ui-status-lastchange{
    color: var(--white-gray-text);
}

.markdown-body > blockquote{
    border-left: 0.25em solid #5882a7;
    color: var(--white-gray-text);
}

.markdown-body > table th,
.markdown-body > table tr:nth-child(2n){
    background-color: var(--navbar-background);
}

.markdown-body > table tr{
    background-color: var(--navbar-alt-background);
}

.panel-body .markdown-body tr{
    background-color: var(--navbar-background);
    border-color: var(--navbar-background);
}

.alert > blockquote{
    border-left: 0.25em solid #ccc;
}

.ui-toc-dropdown {
    background-color: #23272A;
    border: 1px solid rgba(255,255,255,.15);
    box-shadow: 0 6px 12px rgba(255,255,255,.175);
}

/* Dark mode code block */
/* Imported from titangene/hackmd-dark-theme */

.markdown-body pre {
    background-color: #1e1e1e;
    border: 1px solid #555 !important;
    color: #dfdfdf;
    font-weight: 600;
}
.token.operator, .token.entity,
.token.url, .language-css .token.string,
.style .token.string {
    background: unset;
}

/* Dark mode alert boxes */

.alert-info {
    color: #f3fdff;
    background: #40788A;
    border-color: #2F7A95;
}

.alert-warning {
    color: #fffaf2;
    background: #936C36;
    border-color: #AE8443;
}

.alert-danger {
    color: #fff4f4;
    background: #834040;
    border-color: #8C2F2F
}

.alert-success {
    color: #F4FFF2;
    background-color: #436643;
    border-color: #358A28;
}

/* Stylized alert boxes */

.alert-warning>p::before,
.alert-danger>p::before,
.alert-info>p::before {
    white-space: pre;
    font-weight: bold;
}

</style>

<style>
/*
 * Visual Studio 2015 dark style
 * Author: Nicolas LLOBERA <nllobera@gmail.com>
 */

.hljs {
  display: block;
  overflow-x: auto;
  padding: 0.5em;
  background: #1E1E1E;
  color: #DCDCDC;
}

.hljs-keyword,
.hljs-literal,
.hljs-symbol,
.hljs-name {
  color: #569CD6;
}
.hljs-link {
  color: #569CD6;
  text-decoration: underline;
}

.hljs-built_in,
.hljs-type {
  color: #4EC9B0;
}

.hljs-number,
.hljs-class {
  color: #B8D7A3;
}

.hljs-string,
.hljs-meta-string {
  color: #D69D85;
}

.hljs-regexp,
.hljs-template-tag {
  color: #9A5334;
}

.hljs-subst,
.hljs-function,
.hljs-title,
.hljs-params,
.hljs-formula {
  color: #DCDCDC;
}

.hljs-comment,
.hljs-quote {
  color: #57A64A;
  font-style: italic;
}

.hljs-doctag {
  color: #608B4E;
}

.hljs-meta,
.hljs-meta-keyword,
.hljs-tag {
  color: #9B9B9B;
}

.hljs-variable,
.hljs-template-variable {
  color: #BD63C5;
}

.hljs-attr,
.hljs-attribute,
.hljs-builtin-name {
  color: #9CDCFE;
}

.hljs-section {
  color: gold;
}

.hljs-emphasis {
  font-style: italic;
}

.hljs-strong {
  font-weight: bold;
}


.hljs-bullet,
.hljs-selector-tag,
.hljs-selector-id,
.hljs-selector-class,
.hljs-selector-attr,
.hljs-selector-pseudo {
  color: #D7BA7D;
}

.hljs-addition {
  background-color: #144212;
  display: inline-block;
  width: 100%;
}

.hljs-deletion {
  background-color: #600;
  display: inline-block;
  width: 100%;
}
</style>
