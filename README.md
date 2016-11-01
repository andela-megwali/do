# Do!
<a href="https://codeclimate.com/github/andela-megwali/do"><img src="https://codeclimate.com/github/andela-megwali/do/badges/gpa.svg" /></a>
<a href="https://codebeat.co/projects/github-com-andela-megwali-do"><img alt="codebeat badge" src="https://codebeat.co/badges/105a530d-fd9e-4234-8961-1a672817f187" /></a>
<a href='https://coveralls.io/github/andela-megwali/do?branch=develop'><img src='https://coveralls.io/repos/github/andela-megwali/do/badge.svg?branch=develop' alt='Coverage Status' /></a>
[![Build Status](https://travis-ci.org/andela-megwali/do.svg?branch=develop)](https://travis-ci.org/andela-megwali/do)

## Description

Do! is an API (Application Programming Interface) Bucketlist Service that empowers you to keep track of those important things you need to get done in your lifetime. You can manage your bucketlists through any app or device combination which you authorize. Do! integration is seamless with any app, giving you a highly customisable and perhaps familiar experience.
Before you kick the bucket, Do!

## Functions and Features

* Create a Do! account
* Create and manage bucketlists
* Create items in your bucketlists
* Track items that have or have not been done/accomplished
* Search for bucketlist or bucketlist items by name
* Paginate and limit search queries at will
* No unauthorized access to your bucketlist
* Integrates seamlessly with any app


## Instructions For Getting Started

The API documentation can be accessed via this link: [Do! Bucketlist](http://do-bucketlist.herokuapp.com). It explains clearly the rules of engagement with the API in an easily consumable manner.

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





