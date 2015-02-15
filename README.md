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

---
- set up devise, test by going to devise default routes and checking that user is created

---
- configure and check that factorygirl is working

---
- add profile model

---
- update homepage so users can sign in and out
- allow user to create and edit a profile

---
- configure paperclip and add avatars for profiles
- configure s3 for paperclip
- push to heroku and double check s3 configuration
- remember to check styles for paperclip image manipulation

---
- add random profile button and profile index

---
- add a search box
- use where and %LIKE% liberally, its the simplest way
- %ILIKE% is case insensitive but postgres-specific. worth using.
- add names to user profiles. there are a few reasons to put it on profiles instead of users: keep the User model mainly for session/login control and Profile model for info for public use, avoid the dreaded nested forms when we make it user-editable.

---
- add tokens to users and profiles. should I be using friendly_id here? would help when I do lookups, or should I rewrite the .find to use purely tokens?
- for now I will just declare the primary key to be the token field. this might have had complications if I referenced the profile id elsewhere, but that is not the case. alternatively I could have declared it the primary key in the initial migration, or change the find calls in the controller to search for token instead of id

- set up active model serializer
- spec out the api and tdd it
  - list the general approaches: respond_to in existing controllers, roll a separate api controller, use Grape
    respond_to is the simplest, but if we design for splitting the app into smaller components or want to namespace the routes then it gets really compliciated.
    grape is cool especially if the api is going to have a much wider scope, but maybe overkill?
    a separate api controller would be the middle-of-the-road safe choice here.
  - we are going to skip versioning for now, but probably should add it in sometime
  - should the profile post request be namespaced?
  - why are avatars seen separately from profiles?
  - factorygirl and paperclip don't play well together, and uploading images to s3 in test environment is super dubious.
  - we could create a poro called avatar and write methods inside to fetch the image from profile objects, but it seems like unnecessary obfuscation

---
next steps
- POST action for avatar
- token auth?
- add remote image uploading
- typeahead with api?
- versioning the api?
- should I be using instance variables in api controllers?

---
__misc references__
http://stackoverflow.com/questions/7114694/should-i-use-uuids-for-resources-in-my-public-api
