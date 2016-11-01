# Do!
<a href="https://codeclimate.com/github/andela-megwali/do"><img src="https://codeclimate.com/github/andela-megwali/do/badges/gpa.svg" /></a>
<a href="https://codebeat.co/projects/github-com-andela-megwali-do"><img alt="codebeat badge" src="https://codebeat.co/badges/105a530d-fd9e-4234-8961-1a672817f187" /></a>
<a href='https://coveralls.io/github/andela-megwali/do?branch=develop'><img src='https://coveralls.io/repos/github/andela-megwali/do/badge.svg?branch=develop' alt='Coverage Status' /></a>
[![Build Status](https://travis-ci.org/andela-megwali/do.svg?branch=develop)](https://travis-ci.org/andela-megwali/do)

## Description

Do! is an API (Application Programming Interface) Bucketlist Service that empowers you to keep track of those important things you need to get done in your lifetime. Whether you want to see Paris, climb Everest, learn the piano, start a charity or write a will, Do! helps you keep track and live your dreams while you are alive.

You can manage your bucketlists through any app or device combination which you authorize. Do! integration is seamless with any app, giving you a highly customisable and perhaps familiar experience.
Before you kick the bucket, Do!

## Instructions For Getting Started

The API documentation can be accessed by clicking: [Do! Bucketlist](http://do-bucketlist.herokuapp.com). It explains clearly the rules of engagement with the API in an easily consumable manner. Basic information about the API is given below.

### Functions and Features

* Create a Do! account
* Create and manage bucketlists
* Create items in your bucketlists
* Track items that have or have not been done/accomplished
* Search for bucketlist or bucketlist items by name
* Paginate and limit search queries at will
* No unauthorized access to your bucketlist
* Integrates seamlessly with any app

### Dependencies and Frameworks

The application is designed with Ruby 2.3.1, runs on Rails 4.2.7.1 and uses the Puma server. For a list of all "Ruby Gem" dependencies, take a look at the App's [Gemfile](https://github.com/andela-megwali/do/blob/master/Gemfile).

### Do! API Endpoints

Below is the list of available endpoints in the BucketList API. Some end points are not available publicly and hence, can only be accessed when you sign up and log in.

<table>
  <tr>
    <th>End Point</th>
    <th>Functionality</th>
    <th>Public Access</th>
  </tr>

  <tr>
    <td>POST /api/v1/users</td>
    <td>Creates a new user</td>
    <td>TRUE</td>
  </tr>

  <tr>
    <td>POST /api/v1/auth/login</td>
    <td>Logs a user in</td>
    <td>TRUE</td>
  </tr>

  <tr>
    <td>GET /api/v1/auth/logout</td>
    <td>Logs a user out off all active authorized apps</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>POST /api/v1/bucketlists</td>
    <td>Create a new bucketlist</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>GET /api/v1/bucketlists</td>
    <td>List all the created bucketlists</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>GET /bucketlists/:id</td>
    <td>Get a single bucketlist</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>PUT /bucketlists/:id</td>
    <td>Update the selected bucketlist</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>DELETE /bucketlists/:id</td>
    <td>Delete the selected bucketlist</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>POST /bucketlists/:id/items</td>
    <td>Creates a new item in the selected bucketlist</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>GET /bucketlists/:id/items</td>
    <td>Lists all items in the selected bucketlist.</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>GET /bucketlists/:id/items/:item_id</td>
    <td>Fetches a single bucketlist Item</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>PUT /bucketlists/:id/items/:item_id</td>
    <td>Updates a selected bucketlist item</td>
    <td>FALSE</td>
  </tr>

  <tr>
    <td>DELETE /bucketlists/:id/items/:item_id</td>
    <td>Deletes an item in a bucketlist</td>
    <td>FALSE</td>
  </tr>
</table>

### JSON Data Model

The Json data model presentation format for Do! is given below:

      {
        id: 1,
        name: “Travel BucketList”,
        items: [
                 {
                    id: 1,
                    name: “I need to see Paris”,
                    date_created: “2015-08-12 11:57:23”,
                    date_modified: “2015-08-12 11:57:23”,
                    done: False
                 }
        ]
        date_created: “2015-08-12 11:57:23”,
        date_modified: “2015-08-12 11:57:23”
        created_by: “Donna”
      }

### Pagination And Search

Do! API paginates with 20 results per request by default. However, you can easily specify the number of results per request, as well as the page offset desired. This can be done by supplying the <code>page</code> and <code>limit</code> query params in the API request. 

A maximum of 100 results per request is permitted.

  <b>Example Request:</b>

    GET https://do-bucketlist.herokuapp.com/api/v1/bucketlists?page=2&limit=10

  <b>Response:</b>

  10 bucketlist records belonging to the logged in user starting from the 11th gets returned.

#### Searching by Name

Users can search for any owned bucketlist by name using the search query parameter <code>q</code>.

  <b>Example Request:</b>

    GET https://do-bucketlist.herokuapp.com/api/v1/bucketlists?q=travel

  <b>Response:</b>

  This returns a list of all bucketlists with names containing "travel".


### Run Locally

You will require a basic understanding of "Git" and the "Command Line Interface" to use this application.

You also need access to a steady internet connection for the initial installation.

### Installation

 Clone the repo to a directory on your local machine using git clone command as shown below:

    $  git clone https://github.com/andela-megwali/do.git

 Get into the appifly directory:

    $  cd do
    
 Install dependencies

    $  bundle install

 Setup / Migrate database

    $ rails db:setup

 Seed database with data (optional)

    $ rails db:seed

 Start the puma server

    $ rails server

 Visit http://localhost:3000 to view the application on your browser.


### Running the Tests

To test the application, run 'bundle exec rspec' from the appifly directory after you have installed all the dependencies i.e. using 'bundle install' as previously described.

    $  bundle exec rspec


## Versions

Do! API currently has only one version follow us on [Github](https://github.com/andela-megwali/do) to stay up to date with new version releases.


## Limitations

  * It currently doesn't support admin features and scoping of authorized app permissions

## Contributing

You can contribute to this project by forking the repository on GitHub at https://github.com/andela-megwali/do.
We also welcome bug reports and all bugs would be squashed as soon as possible.

Don't leave without fulfilling your dreams. Live it, Do!
