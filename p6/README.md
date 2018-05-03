# Project 6: Introduction to Cybersecurity
CMSC 330, Spring 2018 (Due May 9, 2018)

Ground Rules
------------
**This is an individual assignment. You must work on this project alone.**

Introduction
------------
Congratulations! You've just been hired by **EPSILON** a social media startup that looks suspiciously like Twitter. Through some miracle, the founders have managed dupe investors into funding the company. Using the site, it becomes abundantly clear that there are massive security issues. Since this is a startup, of course they can't afford to hire an expert in cybersecurity. You're a novice, but it's your job now!

Running the Project
-------------------

### Locally

- Run `bundle install` in the project root directory. If you get a permissions error run with `sudo`.
- Run `ruby main.rb` (or `ruby main.rb -o $IP` on Cloud9).
- Open `http://localhost:8080/` (or to your workspace-specific URL on Cloud9). You should see the site.

**Remember to restart `main.rb` after changing `controller.rb`.** Otherwise, changes won't show up. Depending on your local configuration you may have to do some of the following:

- If you don't have bundler, use `gem install bundler` (on Bash for Windows 10 you need to specify the full path when you call `bundle` which can be found with `gem which bundler`).
- If you don't have SQLite3, use `sudo apt-get install sqlite3`.
- If you're getting an issue where Ruby headers cannot be found run `sudo apt-get install ruby-dev`.
- If you're getting an issue where `sqlite.h` is missing run `sudo apt-get install libsqlite3-dev`.
- If bundler can't continue when installing SQLite3 and you're using macOS, upgrade your version of Ruby (we recommend using [RVM](https://rvm.io/)).
- If bundler can't continue when installing SQLite3 and you're using Linux, try `sudo apt-get install build-essential patch` followed by `sudo apt-get install ruby-dev zlib1g-dev liblzma-dev`.

### Grace

If you're using macOS, run the project locally. Grace won't work.

- Log into Grace using `ssh -Y <username>@grace.umd.edu`.
- Run `bundle install --path ~/.gem` in the project root directory.
- Run `chrome &`. You will be able to access the site from this browser window. (If Chrome is giving a core dump, try the following: open the file `~/.cshrc.mine`, comment out `limit maxproc 20` by putting a `#` in front of the line, save the file, logout and log back in.)
- To run the web server, run `ruby main.rb`. You'll notice in the output that "Sinatra has taken stage on PORT_NUMBER_HERE".
- Take that port number and direct the Chrome window to `http://localhost:PORT_NUMBER_HERE/`.

**Remember to restart `main.rb` after changing `controller.rb`.** Otherwise, changes won't show up.

Files
-----
There is only **one source code** file that you will need to make changes to: `controller.rb`. This file contains the core back-end logic and it is also where the web application's vulnerabilities may be found and fixed. You will also be required to interact with and modify the database (which is stored in `data.db`), but you will do this through the database's top-level `sqlite3`.

- Ruby file (you should edit)
  - **controller.rb**: All your modifications should be made to this file.
- Database file (you will edit via the SQLite top-level)
  - **data.db**: The database is housed in this file.
- Provided files (no need to edit, changes will be overwritten!)
  - **public/**: This directory contains all the resources the front-end needs to run.
  - **views/**: This directory contains all the HTML files.
  - **main.rb**: This is the driver file that runs the web server.
  - **Gemfile**: This file contains a list of project dependencies (the server, the database, etc.). These all happen to be Ruby "gems," and bundling them into a "Gemfile" allows us to install them all at once by simply running the command `bundle install` in the same directory.
- Submission Scripts and Other Files
  - **submit.rb**: Execute this script to submit your project to the submit server.
  - **submit.jar** and **.submit**: Don't worry about these files, but make sure you have them.
  - **pack_submission.sh**: Execute this script to zip your project for web submission.

Part 0: Preliminaries
---------------------
The application is separated into three components:

- The front-end which consists of all the HTML and CSS required for rendering the page. You won't have to worry about this at all.
- The back-end which handles all HTTP requests. You will mainly be working on this component.
- The database which persistently stores information. You will also makes some modifications to this.

When a user requests a page (HTTP GET), `main.rb` will display the appropriate page and request all necessary data from `controller.rb`. When a user submits a form (HTTP POST), methods in `controller.rb` will be invoked to modify the database.

This project's back-end (written in Ruby in the file `controller.rb`) is vulnerable to exploitation. Your job is to identify and fix as many of the vulnerabilities as possible. Identifying these issues will require recalling some of the vulnerabilities discussed in class, as well as using your own common sense. This will **require** playing with the site, thinking like an attacker, and trying as hard as possible to break things. Of course, you're also expected to fix the issues once you've found them.

The only code you will be modifying is in `controller.rb`. If you're interested in how the application works, you may check out `main.rb`, but this is not necessary. You will also be modifying `data.db` through the `sqlite3` top-level.

Part 1: Password Hashing
------------------------
Keeping passwords safe is critical for any application. Unfortunately, our application stores passwords in plaintext. You must rectify this.

1. Use the `sqlite3` top-level to augment the "Users" table in `data.db` with a column named "Salt".
2. Modify the application to utilize hashing and salting. You must store the hash in the password column, using the `Digest::SHA256.hexdigest` function, computing your hashes by concatenating the plaintext password and salt together (in that order).
3. Migrate your existing users so their passwords are secure too.

Below are some useful SQL commands. You can see [this SQL cheatsheet](http://cse.unl.edu/%7Esscott/ShowFiles/SQL/CheatSheet/SQLCheatSheet.html) for more commands.

* `SELECT * FROM table;`
  * Description: Returns all records in a table.
  * Example: `SELECT * FROM Users;`
* `ALTER TABLE table ADD COLUMN column type options;`
  * Description: Adds a column to a table.
  * Example: `ALTER TABLE Students ADD COLUMN Hometown varchar(20);`
* `UPDATE table SET column1 = value1, column2 = value2, ... columnk = valuek [WHERE condition(s)];`
  * Description: Updates data in a table.
  * Example: `UPDATE Students SET LastName = 'Jones' WHERE StudentID = 987654321;`

Part 2: Patching Exploits
-------------------------
In the real world, no one will tell you what vulnerabilities are present in your application. So neither will we. However, here is some advice:

1. **Play with the site.** Spend a good bit of time just interacting with it and understanding the pages and how it works.
2. **Walk through the code.** Since we've written most of the application you need to understand what's already there. Make sure you understand all the methods in `controller.rb` and how they fit within the site. The inline documentation should help with this.
3. **Try breaking things.** Wreak havoc! Be destructive! You will find some rather obvious issues, but also some more subtle ones. Remember the types of exploits discussed in class and discussion. Make note of your findings. Your knowledge of `controller.rb` should be helpful in finding possible exploits.
4. **Start fixing.** Enough said.

Here is an index of the vulnerabilities we've learned about either in class or discussion. This is not meant to be exhaustive, nor does it mean that all of these exploits are relevant to this project. It's just to refresh your memory.

* [Buffer Overflow](http://www.cs.umd.edu/class/fall2017/cmsc330/lectures/software-security.pdf#page=15)
* [Shell Injection](http://www.cs.umd.edu/class/fall2017/cmsc330/lectures/software-security.pdf#page=31)
* [Path Traversal](http://www.cs.umd.edu/class/fall2017/cmsc330/lectures/software-security.pdf#page=47)
* [SQL Injection](http://www.cs.umd.edu/class/fall2017/cmsc330/lectures/software-security-2.pdf#page=14)
* [XSS](http://www.cs.umd.edu/class/fall2017/cmsc330/lectures/software-security-2.pdf#page=56)
* [CSRF](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF))

Project Submission and Grading
------------------
This project will be graded out of 100 points.

- Semi-public Tests (20 points). You can submit as many times as you want, but are not provided with the test cases.
- Release tests (80 points). Instead of the usual 3, you will be given 5 tokens which regenerate daily.

You can submit your project in two ways:

- Submit your files directly to the [submit server][submit server] as a zip file by clicking on the submit link in the column "web submission".
![Where to find the web submission link][web submit link]
Then, use the submit dialog to submit your zip file containing all of your source files directly.
![Where to upload the file][web upload example]
Select your file using the "Browse" button, then press the "Submit project!" button. You will need to put it in a zip file since there are several component files. We provide a script `pack_submission.sh` which you can run to make a zip file containing all of the necessary files.
- Submit directly by executing a the submission script on a computer with Java and network access. Included in this project are the submission scripts and related files listed under **Project Files**. These files should be in the directory containing your project. From there you can either execute submit.rb or run the command `java -jar submit.jar` directly (this is all submit.rb does).

No matter how you choose to submit your project, make sure that your submission is received by checking the [submit server][submit server] after submitting.

Academic Integrity
------------------
Please **carefully read** the academic honesty section of the course syllabus. **Any evidence** of impermissible cooperation on projects, use of disallowed materials or resources, or unauthorized use of computer accounts, **will be** submitted to the Student Honor Council, which could result in an XF for the course, or suspension or expulsion from the University. Be sure you understand what you are and what you are not permitted to do in regards to academic integrity when it comes to project assignments. These policies apply to all students, and the Student Honor Council does not consider lack of knowledge of the policies to be a defense for violating them. Full information is found in the course syllabus, which you should review before starting.

[git instructions]: ../git_cheatsheet.md
[submit server]: submit.cs.umd.edu
[web submit link]: ../common-images/web_submit.jpg
[web upload example]: ../common-images/web_upload.jpg
