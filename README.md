# What is this?

Runs the code for [md2gslides](https://github.com/gsuitedevs/md2googleslides) in an Alpine Docker container.


# Why?

I couldn't get md2gslides to work with the nodejs I had installed on Ubuntu 16.04 - even the latest version was throwing errors. This seemed the easiest path around that.

**NOTE** - This has **only** been tested on Ubuntu 16.04. \
Your mileage may vary on other distro's/OSes.

# How do I use it?

## Prerequisites

A valid Google Docs Bearer Token, scoped to `presentations`, saved to a file named `md2gslides.json` in the same location as the `Dockerfile`.

The easiest way I have found to do this is :
- Create a dummy file called `md2gslides.json`
- Build the container as per below, but run it interactively and get a shell
- Once in the shell session, run the same command as the container normally does and it will ask you to authenticate with Google
- Once authenticated, you can view the containers credentials and copy them to your `md2gslides.json` file

```bash
$ sudo docker run -it md2gslides /bin/ash
/md2gslides # md2gslides presentation.md --no-browser
Authorize this app by visiting this url: 
https://accounts.google.com/o/oauth2/v2/auth?access_type=offline&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fpresentations&login_hint=default&response_type=code&client_id={user-stuff}
Enter the code here:
View your presentation at: https://docs.google.com/presentation/d/{random_guid}
/md2gslides # cat ~/.credentials/md2gslides.json 
{
  "default": {
    "access_token": "{access_token_value}",
    "refresh_token": "{refresh_token_value}",
    "scope": "https://www.googleapis.com/auth/presentations",
    "token_type": "Bearer",
    "expiry_date": 1553335672528
  }
}/md2gslides #
```

Alternatively, you could use something like [google-oauth2-token](https://github.com/h2non/google-oauth2-token) to generate the token.

## Usage

The default presentation file name is `slides.md` - it has to be in the same location as `build.sh`.

If you have a file with that name, just run the below to build the container image:

```bash
sudo ./build.sh
```

If your file is **not** called `slides.md`, put the file name after `build.sh`.

For example, if your file is called `presentation.md` :

```bash
sudo ./build.sh presentation.md
```

Once built, run the command:

```bash
sudo ./run.sh
```

Once the container has spun up and exited, it should have translated and uploaded your file to Google Slides. \
The output that appears is the link to the presentation just created - this normally takes only a couple of seconds.

```shell
$ sudo ./run.sh

View your presentation at: https://docs.google.com/presentation/d/{random_guid}
```