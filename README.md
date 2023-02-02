# RSSNews

This is a simple application for working with the json, made as a test task.
Allows you to receive information about weather.

## Summary

  - [Getting Started](#getting-started)
  - [About app](#about-app)
  - [Need to do](#need-to-do)
  - [Built With](#built-with)
  - [Authors](#authors)
  - [License](#license)

## Getting Started
  
These instructions will get you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on how to deploy the project on a live system.

### Prerequisites


Open a terminal and navigate to the directory to copy the repository.
For example, to go to the Desktop, type this:

    cd [folder for your project]


### Installing


Then clone the repository there with the following command:

    https://github.com/dtylai/RSSNews.git
    
    
## About app

The app downloads news from the rss feed. The application supports the ability to store data. The pull to refresh function is also available to download the latest news. The application first downloads news from the database, if there are any, then makes a request for new news and adds them to the already displayed news.The application also supports marking the read news - such news is displayed with a gray background color. By clicking on the news in the table, the user can go to the details of this news and read it in its entirety.

### Some Screenshots
![Simulator Screen Shot - iPhone 14 - 2023-02-02 at 23 38 02](https://user-images.githubusercontent.com/43029960/216444380-547884a3-3e00-425a-abed-717e128af52b.png)
![Simulator Screen Shot - iPhone 14 - 2023-02-02 at 23 38 23](https://user-images.githubusercontent.com/43029960/216444392-16122a93-dcb4-4f87-8bae-c803c1944af5.png)
![Simulator Screen Shot - iPhone 14 - 2023-02-02 at 23 38 30](https://user-images.githubusercontent.com/43029960/216444402-303b9f32-4a10-4bf7-a215-27e93f670c7b.png)

## Need to do

- [ ] Add Tests for buisness logic
- [ ] Add supporting of dark mode
- [ ] Add a selection of news resources
- [ ] Improve UI
## Built With

Using MVC design pattern.
Using KingFisjer, FeedKit, and Realm fraemworks

## Authors

  - **Tulai Dima** 
    [dtylai](https://github.com/dtylai)

## License

 MIT License
