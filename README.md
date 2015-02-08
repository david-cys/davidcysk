# README

This file will document the development process, in chronological order.
Every hr is an indication of a separate step or commit

- create rails application and set up database on local machine
- loosely follow the heroku [getting started guide](https://devcenter.heroku.com/articles/getting-started-with-rails4)
- add haml and rails_12factor to the gemfile
- init a git repository

---
- skip procfile and configuring puma because unnecessary
- push to heroku and github
- check gitignore

---
- skip procfile and configuring puma because unnecessary
- add testing gems, add basic specs to check that everything is working

---
- come up with a rough plan to solve the problem

__plan of approach__

1. create a crud interface for the models first
1. create simple views and forms
1. make sure authentication is working
1. get the picture upload and search working
1. create the api controller and json responses

__alternative plan of approach__

1. spec out and tdd the basic api (controllerspec > factory > modelspec)
1. get the output working while testing with curl or the chrome addon advanced rest client?
1. add for api auth https://github.com/lynndylanhurley/devise\_token\_auth
1. add a controller to serve the views and call the api with faraday/httparty (does this actually work?)
1. add the views and forms

__considerations__

- dont use postgres uuid because that would require messing around with heroku postgres
- generate a short token(securerandom) for users before save, and check for validity. have to add indexes for this field
- devise is a standard choice but might get complicated?
- use paperclip for image handling (need a new aws account maybe, need to add a .env.example file to store env variables? dont commit aws credentials to public repo!)
- what are we matching the search field against? multiple search fields like activeadmin filters or a combined search box?

model:

    user (user auth/sessions, relationships with other users maybe)
    has one profile (1-1)
    integer id
    string name
    string email
    string password
    string token (indexed)

model:

    profile (store profile information, avatar information)
    belongs to user
    has attached file avatar
    text location
    text tagline
    text description

__potential user behaviour__

- User visits homepage
- User can see the last updated profile
- User can navigate to a list of profiles
- User can view any other profile
- ====
- User visits homepage
- User can search for profiles
- ====
- User visits homepage
- User can sign up
- Signed in user can create a profile
- Signed in user can attach an avatar to their profile
- Signed in user can edit their profile

