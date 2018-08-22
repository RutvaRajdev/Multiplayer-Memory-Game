
defmodule Memory.Game do

  #@gameStates %{FTTBO=> "FIRST_TILE_TO_BE_OPENED", STTBO=> "SECOND_TILE_TO_BE_OPENED", WRONG=> "WRONG"}


   def tileClick(tile, state) do
     #IO.inspect tile
     if(! Map.get(tile, "open")) do
       clickCount = Map.get(state, "clickCount")
       clickCount=clickCount+1
       state = Map.put(state, "clickCount", clickCount)

       if(Map.get(state, "gameState") == "FIRST_TILE_TO_BE_OPENED") do
         IO.inspect "case1"
         tiles = Map.get(state, "tiles")
         tileRow = Enum.fetch!(Map.get(state, "tiles"),Map.get(tile, "rowIndex"))
         tileVal = Enum.fetch!(tileRow,Map.get(tile, "columnIndex"))
         new_tile = Map.put(tileVal,"open",true)
         tileRow = List.replace_at(tileRow, Map.get(new_tile, "columnIndex"),new_tile)
         tiles = List.replace_at(tiles, Map.get(new_tile, "rowIndex"),tileRow)
         state = Map.put(state, "tiles", tiles)
         state = Map.put(state, "gameState", "SECOND_TILE_TO_BE_OPENED")
         #IO.inspect Map.get(state, "clickCount")
         %{
           tiles: Map.get(state,"tiles"),
           firstTile: tile,
           secondTile: Map.get(state, "secondTile"),
           gameState: Map.get(state, "gameState"),
           clickCount: Map.get(state,"clickCount")
         }
         #IO.inspect Map.get(state, "gameState")

       else
         if(Map.get(state, "gameState") == "SECOND_TILE_TO_BE_OPENED") do
         IO.inspect "ifloop"
         tileRow = Enum.fetch!(Map.get(state, "tiles"),Map.get(tile, "rowIndex"))
         tileVal = Enum.fetch!(tileRow,Map.get(tile, "columnIndex"))
         new_tile = Map.put(tileVal,"open",true)
         first_tile = Map.get(state, "firstTile")

         tileRow = List.replace_at(tileRow, Map.get(new_tile, "columnIndex"),new_tile)
         tiles = Map.get(state, "tiles")
         tiles = List.replace_at(tiles, Map.get(new_tile, "rowIndex"),tileRow)
         state = Map.put(state, "tiles", tiles)
         #this.state.tiles[tile.rowIndex][tile.columnIndex].open=!this.state.tiles[tile.rowIndex][tile.columnIndex].open;
           if(Map.get(first_tile, "tileLetter") == Map.get(tile, "tileLetter")) do
             IO.inspect "matched"

              %{
               tiles: Map.get(state,"tiles"),
               firstTile: Map.get(state, "firstTile"),
               secondTile: Map.get(state, "secondTile"),
               gameState: "FIRST_TILE_TO_BE_OPENED",
               clickCount: Map.get(state,"clickCount")
             }
             IO.inspect state

             #:timer.sleep(1000)
             IO.inspect "sleep"
             IO.inspect state
             IO.inspect tile
             IO.inspect Map.get(state, "firstTile")
               # timer1 = setTimeout(
               #   () => {
             #tiles = Map.get(state, "tiles")
             #tile =
             tileRow = Enum.fetch!(tiles,Map.get(tile, "rowIndex"))
             tileVal = Enum.fetch!(tileRow,Map.get(tile, "columnIndex"))
             new_tile = Map.put(tileVal,"tileLetter","✓")
             tileRow = List.replace_at(tileRow, Map.get(new_tile, "columnIndex"),new_tile)
             tiles = List.replace_at(tiles, Map.get(new_tile, "rowIndex"),tileRow)
             state = Map.put(state, "tiles", tiles)

             tiles = Map.get(state, "tiles")
             firstTile = Map.get(state,"firstTile")
             tileRow = Enum.fetch!(tiles,Map.get(firstTile, "rowIndex"))
             tileVal = Enum.fetch!(tileRow,Map.get(firstTile, "columnIndex"))
             new_tile = Map.put(tileVal,"tileLetter","✓")
             tileRow = List.replace_at(tileRow, Map.get(new_tile, "columnIndex"),new_tile)
             tiles = List.replace_at(tiles, Map.get(new_tile, "rowIndex"),tileRow)
             state = Map.put(state, "tiles", tiles)

             state = Map.put(state, "gameState", "FIRST_TILE_TO_BE_OPENED")
             #this.state.tiles[tile.rowIndex][tile.columnIndex].tileLetter = '✓';
             #this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].tileLetter = '✓';
             %{
               tiles: Map.get(state,"tiles"),
               firstTile: Map.get(state, "firstTile"),
               secondTile: Map.get(state, "secondTile"),
               gameState: "FIRST_TILE_TO_BE_OPENED",
               clickCount: Map.get(state,"clickCount")
             }
               #     };}
               #     ,200);
             else
               state = Map.put(state, "gameState", "WRONG")
               state = Map.put(state, "secondTile", tile)
               IO.inspect state
               %{
                 tiles: Map.get(state,"tiles"),
                 firstTile: Map.get(state, "firstTile"),
                 secondTile: Map.get(state, "secondTile"),
                 gameState: Map.get(state, "gameState"),
                 clickCount: Map.get(state,"clickCount")
               }

               #:timer.sleep(1000)

               # tiles = Map.get(state, "tiles")
               # firstTile = Map.get(state,"firstTile")
               # tileRow = Enum.fetch!(Map.get(state, "tiles"),Map.get(firstTile, "rowIndex"))
               # tileVal = Enum.fetch!(tileRow,Map.get(firstTile, "columnIndex"))
               # new_tile = Map.put(tileVal,"open",false)
               # tileRow = List.replace_at(tileRow, Map.get(new_tile, "columnIndex"),new_tile)
               # tiles = List.replace_at(tiles, Map.get(new_tile, "rowIndex"),tileRow)
               # state = Map.put(state, "tiles", tiles)
               #
               # tiles = Map.get(state, "tiles")
               #
               # tileRow = Enum.fetch!(Map.get(state, "tiles"),Map.get(tile, "rowIndex"))
               # tileVal = Enum.fetch!(tileRow,Map.get(tile, "columnIndex"))
               # new_tile = Map.put(tileVal,"open",false)
               # tileRow = List.replace_at(tileRow, Map.get(new_tile, "columnIndex"),new_tile)
               # tiles = List.replace_at(tiles, Map.get(new_tile, "rowIndex"),tileRow)
               # state = Map.put(state, "tiles", tiles)
               # state = Map.put(state, "gameState", "FIRST_TILE_TO_BE_OPENED")
               # state = Map.put(state, "firstTile", nil)
               # state = Map.put(state, "secondTile", nil)
               # %{
               #   tiles: Map.get(state,"tiles"),
               #   firstTile: Map.get(state, "firstTile"),
               #   secondTile: Map.get(state, "secondTile"),
               #   gameState: Map.get(state, "gameState"),
               #   clickCount: Map.get(state,"clickCount")

               # timer = setTimeout(
               #   () => {
               #     this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].open=false;
               #     this.state.tiles[tile.rowIndex][tile.columnIndex].open=false;
               #     this.setState({gameState: gameStates.FTTBO, tiles: this.state.tiles, firstTile: null, secondTile:null});
               #   }
               #   ,1000);

             end
          else
            #clearTimeout(timer);
            tiles = Map.get(state, "tiles")
            firstTile = Map.get(state,"firstTile")
            tileRow = Enum.fetch!(Map.get(state, "tiles"),Map.get(firstTile, "rowIndex"))
            tileVal = Enum.fetch!(tileRow,Map.get(firstTile, "columnIndex"))
            new_tile = Map.put(tileVal,"open",false)
            tileRow = List.replace_at(tileRow, Map.get(new_tile, "columnIndex"),new_tile)
            tiles = List.replace_at(tiles, Map.get(new_tile, "rowIndex"),tileRow)
            state = Map.put(state, "tiles", tiles)

            tiles = Map.get(state, "tiles")
            secondTile = Map.get(state,"secondTile")
            tileRow = Enum.fetch!(Map.get(state, "tiles"),Map.get(secondTile, "rowIndex"))
            tileVal = Enum.fetch!(tileRow,Map.get(secondTile, "columnIndex"))
            new_tile = Map.put(tileVal,"open",false)
            tileRow = List.replace_at(tileRow, Map.get(new_tile, "columnIndex"),new_tile)
            tiles = List.replace_at(tiles, Map.get(new_tile, "rowIndex"),tileRow)
            state = Map.put(state, "tiles", tiles)

            tiles = Map.get(state, "tiles")
            tileRow = Enum.fetch!(Map.get(state, "tiles"),Map.get(tile, "rowIndex"))
            tileVal = Enum.fetch!(tileRow,Map.get(tile, "columnIndex"))
            new_tile = Map.put(tileVal,"open",true)
            tileRow = List.replace_at(tileRow, Map.get(new_tile, "columnIndex"),new_tile)
            tiles = List.replace_at(tiles, Map.get(new_tile, "rowIndex"),tileRow)
            state = Map.put(state, "tiles", tiles)

            state = Map.put(state, "gameState", "SECOND_TILE_TO_BE_OPENED")
            state = Map.put(state, "firstTile", tile)

            %{
              tiles: Map.get(state,"tiles"),
              firstTile: Map.get(state, "firstTile"),
              secondTile: Map.get(state, "secondTile"),
              gameState: Map.get(state, "gameState"),
              clickCount: Map.get(state,"clickCount")
            }
            #this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].open=false;
            #this.state.tiles[this.state.secondTile.rowIndex][this.state.secondTile.columnIndex].open=false;
            #this.state.tiles[tile.rowIndex][tile.columnIndex].open=true;
            #this.setState({gameState: gameStates.STTBO, tiles: this.state.tiles, firstTile: tile});
          end
        end
      end
    end
    def new(gameState) do
      #IO.inspect gameState
      gameState

    end

    def reset(gameState) do
      IO.inspect gameState
      IO.inspect "resetex"
      gameState
    end

    def timerFunc1() do

      IO.inspect "func"

    end
  end
       # else if (this.state.gameState==gameStates.STTBO) {
       #
       #
       #
       #   this.state.tiles[tile.rowIndex][tile.columnIndex].open=!this.state.tiles[tile.rowIndex][tile.columnIndex].open;
       #   if(this.state.firstTile.tileLetter == tile.tileLetter){
       #
       #       this.setState({gameState: gameStates.FTTBO, tiles: this.state.tiles});
       #       timer1 = setTimeout(
       #         () => {
       #           this.state.tiles[tile.rowIndex][tile.columnIndex].tileLetter = '✓';
       #           this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].tileLetter = '✓';
       #           this.setState({gameState: gameStates.FTTBO, tiles: this.state.tiles});}
       #           ,200);
       #
       #   }
       #
       #   else{
       #
       #     this.setState({gameState: gameStates.WRONG, tiles: this.state.tiles, secondTile: tile});
       #
       #     timer = setTimeout(
       #       () => {
       #         this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].open=false;
       #         this.state.tiles[tile.rowIndex][tile.columnIndex].open=false;
       #         this.setState({gameState: gameStates.FTTBO, tiles: this.state.tiles, firstTile: null, secondTile:null});
       #       }
       #       ,1000);
       #
       #   }
       # }
       #
       # else if(this.state.gameState==gameStates.WRONG)  {
       #     clearTimeout(timer);
       #
       #     this.state.tiles[this.state.firstTile.rowIndex][this.state.firstTile.columnIndex].open=false;
       #     this.state.tiles[this.state.secondTile.rowIndex][this.state.secondTile.columnIndex].open=false;
       #     this.state.tiles[tile.rowIndex][tile.columnIndex].open=true;
       #     this.setState({gameState: gameStates.STTBO, tiles: this.state.tiles, firstTile: tile});
       #
       # }


  #   clickCount = 0
  #   columns = 4
  #   defmodule Tilestruct do#
  #     defstruct tileLetter: "A", open: false, rowIndex: 0, columnIndex: 0
  # end
  #
  #   letters = Enum.shuffle(["A","A","B","B","C","C","D","D","E","E","F","F","G","G","H","H"])

    #tiles = [[[],[],[],[],[]],[[],[],[],[]],[[],[],[],[]],[[],[],[],[]]]
    #tiles |> Enum.at(0) |> Enum.at(0) = struct(Tilestruct, [tileLetter: letters[0*columns+0],open: false, rowIndex: 0, columnIndex: 0])

    # tiles = %{
    #
    # }



    #tiles[0][0] = %Tilestruct{tileLetter: letters[0*columns+0], open: false, rowIndex: 0, columnIndex: 0}
    #tiles[0][0]= %{tileLetter: letters[0*columns+0], open: false, rowIndex: 0, columnIndex: 0}
      #tiles[0][1] = %{tileLetter => letters[0*columns+1], open => false, rowIndex=> 0, columnIndex=> 1}
      #tiles[0][2] = %{tileLetter => letters[0*columns+2], open => false, rowIndex=> 0, columnIndex=> 2}
      #tiles[0][3] = %{tileLetter => letters[0*columns+3], open => false, rowIndex=> 0, columnIndex=> 3}
      #tiles[1][0] = %{tileLetter => letters[1*columns+0], open => false, rowIndex=> 1, columnIndex=> 0}
      #tiles[1][1] = %{tileLetter => letters[1*columns+1], open => false, rowIndex=> 1, columnIndex=> 1}
      #tiles[1][2] = %{tileLetter => letters[1*columns+2], open => false, rowIndex=> 1, columnIndex=> 2}
      #tiles[1][3] = %{tileLetter => letters[1*columns+3], open => false, rowIndex=> 1, columnIndex=> 3}
      #tiles[2][0] = %{tileLetter => letters[2*columns+0], open => false, rowIndex=> 2, columnIndex=> 0}
      #tiles[2][1] = %{tileLetter => letters[2*columns+1], open => false, rowIndex=> 2, columnIndex=> 1}
      #tiles[2][2] = %{tileLetter => letters[2*columns+2], open => false, rowIndex=> 2, columnIndex=> 2}
      #tiles[2][3] = %{tileLetter => letters[2*columns+3], open => false, rowIndex=> 2, columnIndex=> 3}
      #tiles[3][0] = %{tileLetter => letters[3*columns+0], open => false, rowIndex=> 3, columnIndex=> 0}
      #tiles[3][1] = %{tileLetter => letters[3*columns+1], open => false, rowIndex=> 3, columnIndex=> 1}
      #tiles[3][2] = %{tileLetter => letters[3*columns+2], open => false, rowIndex=> 3, columnIndex=> 2}
      #tiles[3][3] = %{tileLetter => letters[3*columns+3], open => false, rowIndex=> 3, columnIndex=> 3}

      # %{
      #   tiles: tiles,
      #   gameState: "FIRST_TILE_TO_BE_OPENED",
      #   firstTile: nil,
      #   secondTile: nil
      # }


      #this.setState({tiles=> tiles, gameState=> gameStates.FTTBO, firstTile=> null, secondTile=> null});
