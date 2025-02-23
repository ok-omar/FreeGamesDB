import requests
import json
import csv
import time

# API endpoint for fetching all free games
games_url = "https://www.freetogame.com/api/games"


try:
    # Request all games
    games_response = requests.get(games_url)

    # Check if the request was successful (status code 200)
    if games_response.status_code == 200:
        
        games_data = games_response.json()  # Convert the response to JSON
        # Open the file
        with open("src/consumer/data/games.csv", "w", newline="", encoding="utf-8") as csv_file:
            writer = csv.writer(csv_file)

            # Write the header of the csv file
            writer.writerow(["ID", "Title", "Thumbnail", "Status", "short_description", "Description", "game_url", "Genre", "Platform", "Publisher", "Developer", "Release Date", "Os", "Processor", "Memory", "Graphics", "Storage"])

            # Loop through all the games found in the API
            for game_data in games_data:

                # Request the game using the API
                game_url = f"https://www.freetogame.com/api/game?id={game_data['id']}"
                game_response = requests.get(game_url)
                game_data = game_response.json()

                # Check if minimum requirements exist
                min_system_req = game_data.get("minimum_system_requirements", None)

                # If system requirements are available, write them to the CSV, else write "N/A"
                if min_system_req:
                    writer.writerow([
                        game_data["id"],
                        game_data["title"],
                        game_data["thumbnail"],
                        game_data["status"],
                        game_data["short_description"],
                        game_data["description"],
                        game_data["game_url"],
                        game_data["genre"],
                        game_data["platform"],
                        game_data["publisher"],
                        game_data["developer"],
                        game_data["release_date"],
                        min_system_req.get("os", "N/A"),
                        min_system_req.get("processor", "N/A"),
                        min_system_req.get("memory", "N/A"),
                        min_system_req.get("graphics", "N/A"),
                        min_system_req.get("storage", "N/A")
                    ])
                else:
                    # If no system requirements, write "N/A" for each
                    writer.writerow([
                        game_data["id"],
                        game_data["title"],
                        game_data["thumbnail"],
                        game_data["status"],
                        game_data["short_description"],
                        game_data["description"],
                        game_data["game_url"],
                        game_data["genre"],
                        game_data["platform"],
                        game_data["publisher"],
                        game_data["developer"],
                        game_data["release_date"],
                        "N/A",  # For OS
                        "N/A",  # For Processor
                        "N/A",  # For Memory
                        "N/A",  # For Graphics
                        "N/A"   # For Storage
                    ])
                print(f"Added game {game_data["title"]}")
                time.sleep(1)


            
        # with open("src/consumer/data/games.json", "w", encoding="utf-8") as json_file:
        #     json.dump(games_data, json_file, indent=4)

        
    else:
        print(f"Failed to fetch data. Status code: {games_response.status_code}")
except Exception as e:
    print(f"An error occurred: {e}")
