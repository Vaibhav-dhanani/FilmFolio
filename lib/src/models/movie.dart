class Movie {
   String? name;
   double? rating;
   String? year;
   List<Map>? cast;
   List<Map>? comment;
   String? description;
   //String? images;
   String? images;
   String? type;
   String? director;
//string means not-null -so- it must be initialize
  Movie({
      this.name,
     this.year,
     this.cast,
     this.description,
     this.images,
     this.rating,
     this.type,
     this.director,
  });
}

final forYouImages =[
  Movie(images: "assets/images/for_your_images/cruella.jpeg" ),
  Movie(images: "assets/images/for_your_images/101.jpg"),
  Movie(images: "assets/images/for_your_images/stranger_things.jpg"),
];

final popularImages = [
  Movie(
    images: "assets/images/popular_images/Dune_(2021_film).jpg",
    name: "Dune",
    year: "2021",
    cast: [
      {"name": "Timothée Chalamet", "role": "Paul Atreides", "image":""},
      {"name": "Rebecca Ferguson", "role": "Lady Jessica" ,"image":""},
      {"name": "Oscar Isaac", "role": "Duke Leto Atreides","image":""},
      {"name": "Zendaya", "role": "Chani","image":""},
      {"name": "Jason Momoa", "role": "Duncan Idaho","image":""},
      {"name": "Stellan Skarsgård", "role": "Baron Vladimir Harkonnen","image":""},
      {"name": "Josh Brolin", "role": "Gurney Halleck","image":""},
      {"name": "Javier Bardem", "role": "Stilgar","image":""},
      {"name": "Sharon Duncan-Brewster", "role": "Dr. Liet Kynes","image":""},
      {"name": "Dave Bautista", "role": "Glossu Rabban","image":""},
    ],
    description: "Dune is a 2021 science fiction film directed by Denis Villeneuve, based on the 1965 novel by Frank Herbert. The film is set in a distant future amidst a feudal interstellar society, where noble houses vie for control of the desert planet Arrakis.",
    rating: 8.2,
    type: "Hollywood",
    director: "Denis Villeneuve",
  ),

  Movie(
    images: "assets/images/popular_images/shang_chi.jpg",
    name: "Shang-chi",
    year: "2021",
    rating: 6.4,

  ),
  Movie(
    images: "assets/images/popular_images/narcos.jpg",
    name: "Narcos",
    year: "2021",
    rating: 9.0,

  ),
  Movie(
    images: "assets/images/popular_images/stranger_things.jpg",
    name: "Stranger Things",
    year: "2021",
    rating: 8.5,

  ),
  // Add more popular movies as needed
];

final legendaryImages =[
  Movie(
    images: "assets/images/inception.jpg",
    name: "inception",
    year: "1979",
    rating: 8.5,

  ),
  Movie(
    images: "assets/images/demon_slayer.jpg",
    name: "demon_slayer",
    year: "2006",
    rating: 8.5,

  ),
  Movie(
    images: "assets/images/interstellar.jpg",
    name: "interstellar",
    year: "2021",
    rating: 8.5,

  ),
  Movie(
    images: "assets/images/the_dark_knight.jpg",
    name: "the_dark_knight",
    year: "2021",
    rating: 8.5,

  ),
  Movie(
    images: "assets/images/popular_images/stranger_things.jpg",
    name: "stranger_things",
    year: "2021",
    rating: 9.0,

  ),
  Movie(
    images: "assets/images/for_your_images/cruella.jpeg",
    name: "stranger_things",
    year: "2021",
    rating: 9.0,

  ),
];

final genresImages=[
  Movie(
    name: "Horror",
    images:"assets/images/horror.jpg",
  ),
  Movie(
    name: "Fantasy",
    images: "assets/images/fantasy.jpg",

  ),
  Movie(
    name:"History",
    images: "assets/images/history.jpg",

  ),
  Movie(
    name: "Detective",
    images: "assets/images/detective.jpg",

  ),
  Movie(
    name: "Action",
    images: "assets/images/action.jpg",
  ),
];
