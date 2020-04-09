//this is used to get needed info and calculate only the result for each player

int calculateScore(
  String gamePlay,
  int pEats, //number of eats for a particular player
) {
  var pScore = 0;

  switch (gamePlay) {
    case 'queens':
      if (pEats != 0) pScore += pEats * -25;
      break;
    case 'king':
      if (pEats != 0) pScore += pEats * -75;
      break;
    case 'diamonds':
      if (pEats != 0) pScore += pEats * -10;
      break;
    case 'collections':
      if (pEats != 0) pScore += pEats * -15;
  }

  return pScore;
}
