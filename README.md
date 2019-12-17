# Ruby on Rails Application : BoBato

<h1 align="center">
  <br>
  <p>
  <img src="app/assets/images/logo-bobato-dark.png" alt="Bobato" width="200">
  </p>
</h1>

## Version :

  * Ruby 2.5.1
  * Rails 5.2.4

## How to get started :

```
$ git clone https://github.com/Marius-creator/BoBato.git
$ cd BoBato
$ Bundle install
$ rails db:drop db:create db:migrate db:seed
```

## Useful address :

- Repo GitHub : https://github.com/Marius-creator/BoBato
- App Heroku (dev): https://bobato-dev.herokuapp.com/
- App Heroku (prod) : https://bobato.herokuapp.com/
- Trello : https://trello.com/b/HnrkJrHv/bobato

## What is the purpose of BoBato :

### Presentation :

This application has been created to connect boat owners (usually boat rental agencies or boat builders) with skippers (boat captains).

If I am a boat owner, I can have my boat transported from point A to point B (for example from Marseille to Mykonos). And if I am a skypper, I can get an amount of money.

### How to use :
First of all I have to sign-up/sign-in as user to use the application
After that, I can either be a Boat onwer or a skipper. Let see, what can do...

### If I am a Boatowner :

  1. The boat owner creates his delivery request by filling up a form with details below :

    - Type of boat
    - Required boating licence
    - Port of departure
    - Port of arrival
    - Convoy delivery date
    - delivering price
    - Upload boat's pictures

  2. Then, He receives applications from skippers wishing to carry out the delivery. It is up to him to select the skipper who suits him best.

  3. The confirmation between the boat owner and the skipper is done via a Stripe transaction.

  4. An email is sent to the selected skypper  

### If I am a Skipper

  1. The skipper has the opportunity to complete his profile in order to highlight his experiences. His profile page will be used to convince boat owners to hire him to carry out convoys.

    - surname, first name, age, city, description
    - boating licence he holds
    - His professional profile (diplomas, professional background)  
    - Upload profile's pictures

  2. A skipper has the possibility to apply on delivery announcement by filling in a motivation form.

  3. The skypper received an email to announce him if he is accepted for the delivery. In the case of acceptance, he will receive a money transfer from the boat owner


## Team :

  - **Yoni BENATAR**
  - **Ombeline DE JUNNEMANN**
  - **Julien DU**
  - **Youcef KHALAINOU**
  - **Marius MARTINEZ**

>  Big thank you to our mentor: Quentin Prevost Corsaire Session 7 and   Lucien.

## Credit :

This project has been realised to validate the training "The Hacking Project"
Website :  [*The Hacking Project* website](https://www.thehackingproject.org/).
