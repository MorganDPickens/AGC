// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;



contract learnStructs {

  struct Movie {
   
   string title;
   string director;
   uint movie_id; 
   string comedy;
      
  }
      Movie movie;
      Movie comedy; 



    function setMovie() public {
        movie =  Movie('blade runner', 'Ridley Scot', 1, 'not');
        movie = Movie('rush hour', 'steven king', 2, 'not');
        comedy = Movie('rush hour2', 'steven king', 3, 'yes');

    }
    function GetMovieid () view public returns (uint) {
            return movie.movie_id;
             
    
    }
    function GetMovieidCom () view public returns (uint){
             return comedy.movie_id; 
    }
}