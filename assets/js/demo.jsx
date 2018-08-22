/*
Sites Referred:
https://www.youtube.com/watch?v=GGKH67PGzvA
https://codereview.stackexchange.com/questions/184488/memory-game-in-react
https://github.com/jdlehman/react-memory-game
*/

import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';
import classNames from 'classnames';

export default function run_demo(root, channel) {
  ReactDOM.render(<GameBoard channel={channel} />, root);
}

var timer = 0;
var timer1 = 0;
var tiles;
var clickCount = 0;
var rows = 4;
var columns = 4;

const gameStates = {FTTBO: "FIRST_TILE_TO_BE_OPENED", STTBO: "SECOND_TILE_TO_BE_OPENED", WRONG: "WRONG"};

function shuffleLetters(array){
  var j, x, i;
  for(i=array.length; i; i--){
    j=Math.floor(Math.random() * i);
    x=array[i-1];
    array[i-1] = array[j];
    array[j] = x;
  }
}

class GameBoard extends React.Component {

  constructor(props){
    super(props);
    this.channel = props.channel;
    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp) });

    this.resetGame = this.resetGame.bind(this);

    //this.resetGame();
    tiles = Array.apply(null, Array(rows)).map(function(e){

        return Array(columns);
    });

    var letters = ['A','A','B','B','C','C','D','D','E','E','F','F','G','G','H','H'];
    var id = 0
    shuffleLetters(letters);
    for(var rowIndex = 0; rowIndex<rows; rowIndex++){
      for(var columnIndex=0; columnIndex<columns; columnIndex++){
        id = id + 1
        tiles[rowIndex][columnIndex] = {tileLetter: letters[rowIndex*columns+columnIndex], open: false, rowIndex: rowIndex, columnIndex: columnIndex, id: id}
      }
    }
    this.state={tiles: tiles, gameState: gameStates.FTTBO, firstTile: null, secondTile: null, clickCount: 0};
    this.channel.push("new", {game: this.state}).receive("ok", resp => {this.gotView(this.state)});
  }

  gotView(st) {
    this.setState(st.game);
    //console.log(st.game);
  }

  updateView(st, tile) {
    this.setState(st.game);
    if(this.state.gameState == "WRONG") {
    timer = setTimeout(
      () => {
        this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].open=false;
        this.state.tiles[tile.rowIndex][tile.columnIndex].open=false;
        this.setState({gameState: gameStates.FTTBO, tiles: this.state.tiles, firstTile: null, secondTile:null});
        this.channel.push("update", {game: this.state}).receive("ok", resp => {console.log("wrong")})
      }
      ,1000);

    }
    else{
      clearTimeout(timer);
      this.channel.push("update", {game: this.state}).receive("ok", resp => {console.log("wrong")})
    }
  }
  render() {
    console.log(this.state);
    const tilesRendered = this.state.tiles.map((rowOfTiles, rowIndex)=><tr>{rowOfTiles.map((tile, indexOfTileInRow)=><td onClick={()=>this.channel.push("click", {tile: tile,state: this.state}).receive("ok", resp => {this.updateView(resp, tile)})}>
    <Tile tile = {tile}/></td>)}</tr>);

    return (
      <div>
        <div className="clicks-number">
          Number of clicks: {this.state.clickCount}

        </div>
        <table align="center">
          <tbody>

            {tilesRendered}

          </tbody>
        </table>
        <div>
          <div className="reset-btn" onClick={this.resetGame}> Reset </div>
        </div>
      </div>

    );
  }

  // tileClick(tile){
  //
  //   if(!tile.open){
  //     clickCount = clickCount + 1;
  //
  //     if(this.state.gameState==gameStates.FTTBO){
  //
  //       this.state.tiles[tile.rowIndex][tile.columnIndex].open=true;
  //       this.setState({tiles: this.state.tiles, firstTile: tile, gameState: gameStates.STTBO});
  //     }
  //     else if (this.state.gameState==gameStates.STTBO) {
  //
  //
  //
  //       this.state.tiles[tile.rowIndex][tile.columnIndex].open=!this.state.tiles[tile.rowIndex][tile.columnIndex].open;
  //       if(this.state.firstTile.tileLetter == tile.tileLetter){
  //
  //           this.setState({gameState: gameStates.FTTBO, tiles: this.state.tiles});
  //           timer1 = setTimeout(
  //             () => {
  //               this.state.tiles[tile.rowIndex][tile.columnIndex].tileLetter = '✓';
  //               this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].tileLetter = '✓';
  //               this.setState({gameState: gameStates.FTTBO, tiles: this.state.tiles});}
  //               ,200);
  //
  //       }
  //
  //       else{
  //
  //         this.setState({gameState: gameStates.WRONG, tiles: this.state.tiles, secondTile: tile});
  //
  //         timer = setTimeout(
  //           () => {
  //             this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].open=false;
  //             this.state.tiles[tile.rowIndex][tile.columnIndex].open=false;
  //             this.setState({gameState: gameStates.FTTBO, tiles: this.state.tiles, firstTile: null, secondTile:null});
  //           }
  //           ,1000);
  //
  //       }
  //     }
  //
  //     else if(this.state.gameState==gameStates.WRONG)  {
  //         clearTimeout(timer);
  //
  //         this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].open=false;
  //         this.state.tiles[this.state.secondTile.rowIndex][this.state.secondTile.columnIndex].open=false;
  //         this.state.tiles[tile.rowIndex][tile.columnIndex].open=true;
  //         this.setState({gameState: gameStates.STTBO, tiles: this.state.tiles, firstTile: tile});
  //
  //     }
  //   }
  // }

  resetGame() {
    clickCount = 0;
    tiles = Array.apply(null, Array(rows)).map(function(e){
        return Array(columns);
    });
    //console.log(tiles);
    var letters = ['A','A','B','B','C','C','D','D','E','E','F','F','G','G','H','H'];

    shuffleLetters(letters);
    for(var rowIndex = 0; rowIndex<rows; rowIndex++){
      for(var columnIndex=0; columnIndex<columns; columnIndex++){
        tiles[rowIndex][columnIndex] = {tileLetter: letters[rowIndex*columns+columnIndex], open: false, rowIndex: rowIndex, columnIndex: columnIndex}
      }
      this.setState({tiles: tiles, gameState: gameStates.FTTBO, firstTile: null, secondTile: null, clickCount: 0});
     }
     this.channel.push("reset", {game: this.state}).receive("ok", resp => {this.gotView(this.state)});
     console.log(this.setState)
   }
}

class Tile extends React.Component{


  render(){
    var tileClass = classNames('tile',
      {'tile--tilecorrect': this.props.tile.tileLetter == "✓" },
      {'tile--tileflipped' : this.props.tile.open && !(this.props.tile.tileLetter === "✓")}
    );

    return(
      <div className={tileClass}>
        <span>
          {
            this.props.tile.open ? this.props.tile.tileLetter:"?"
          }
        </span>
      </div>

      );
  }
}
