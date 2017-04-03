#  README  #

Welcome to the Labcoat source code!
Labcoat is an open-source, client-side frontend for Mastodon written in Literate CoffeeScript for use with Laboratory and React.js.
Its source files are parseable as regular Markdown documents, and this file is in fact part of the Laboratory source!

##  How to Read Labcoat Source Code  ##

Each Labcoat source code file is broadly split up into two parts: the *documentation*, which describes what the file does and how to use it, and the *implementation*, which actually implements the described algorithms and processes.
The documentation is (with the exception of this readme and the installation guide) always the first section in a file and titled "Usage".
The implementation will fill remaining sections, and generally should be safe to ignore—any important information should have already been covered in the description of what goes on in the file.
However, you can turn to the implementation if you are curious on how specific Labcoat features are actually coded.
(And, of course, if you are a computer, the compiled implementation is the only part of this file you will ever see!)

###  What to read:

If you're looking to use Labcoat in your project, then you should definitely familiarize yourself with the [installation guide](INSTALLING.litcoffee), which will provide details on Labcoat configuration and usage.
You might want to take a cursory glance at the files in the other folders if you are interested in providing Labcoat with your own styling.

##  Contributing  ##

Want to contribute to Labcoat?
That's great!
Feel free to submit a Pull Request through Github.
However, here are some guidelines to help your work be successful:

###  Document your code:

Labcoat is written in Literate CoffeeScript, so be literate about it!
Code should be written in a manner that flows well narratively, and written documentation explaining what it does in plain English should accompany any code.
It should be possible to understand *what* a file does by only reading the Markdown; the code exists to describe to a computer *how*.

###  Be mindful of data mutability:

If a property shouldn't be overwritten, you should define it with `Object.definePropery()`.
If an object should be considered immutable, use `Object.freeze()`.
You will find that most of the time when defining objects in our code one or both of these functions will come into play.

###  Be concise and elegant:

CoffeeScript is a very powerful language for writing code that is elegant and easy-to-read.
Take advantage of this!
Having text explanations above and below doesn't excuse messy code.

##  Implementation  ##

This file doesn't actually do much, but it's the first thing that our Labcoat script runs.

###  Introduction:

This is the first file in our compiled source, so let's identify ourselves real fast.

    ###

        ............... LABCOAT ................

         A client-side frontend for Mastodon, a
        free & open-source social network server
                   - - by Kibigo! - -

            Licensed under the MIT License.
               Source code available at:
          https://github.com/marrus-sh/labcoat

                    Version 0.2.2

    ###

Labcoat uses an [MIT License](../LICENSE.md) because it's designed to be easily customizable and extensible.
Feel free to make it your own!

###  Initial setup:

We'll use `彁` in place of `React.createElement` for brevity.
*彁* is what is known as a ["ghost character"](https://en.wikipedia.org/wiki/JIS_X_0208#Kanji_from_unknown_sources)—which is to say that it doesn't have any intrinsic meaning.
We use it because it's short and easy to spot.

    Object.defineProperty window, "彁", {value: React.createElement}

If Labcoat was installed directly onto a server, then its location will be `window.ReactPureRenderMixin`, but if it is loaded through the react-addons script, its location will be `React.addons.PureRenderMixin`.
We can't be bothered to test both every time we need to use it, so we'll store it locally at `ReactPureRenderMixin` if it hasn't already been defined on the window.

    ReactPureRenderMixin = React.addons.PureRenderMixin unless ReactPureRenderMixin?
