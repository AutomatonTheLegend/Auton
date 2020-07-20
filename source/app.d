import std.stdio;
import std.random;
import derelict.sdl2.sdl;

SDL_Renderer* renderer;

const windowWidth = 1024;
const windowHeight = 512;
const cellSize = 4;
const stateWidth = windowWidth / cellSize;
const stateHeight = windowHeight / cellSize;
alias State = int[stateWidth][stateHeight];

void render(State state) {
	for(int x = 0; x < stateWidth; x++) {
		for(int y = 0; y < stateHeight; y++) {
			if (state[y][x])
				SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
			else
				SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);

			SDL_Rect rect = {
				x: x * cellSize,
				y: y * cellSize,
				w: cellSize,
				h: cellSize
			};
			SDL_RenderFillRect(renderer, &rect);
		}
	}
}

void main()
{
	 // Load the SDL 2 library.
    DerelictSDL2.load();
	SDL_Window* window = SDL_CreateWindow("automaton",
		SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
		windowWidth, windowHeight,
		SDL_WINDOW_SHOWN);
	scope(exit)
		SDL_DestroyWindow(window);
	renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
	scope(exit)
		SDL_DestroyRenderer(renderer);
	State state;
	foreach(ref row; state)
		foreach(ref cell; row)
			cell = uniform!"[]"(0, 1);
	SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
	SDL_RenderClear(renderer);
	state.render();
	SDL_RenderPresent(renderer);
	SDL_Delay(1000);
	writeln("Edit source/app.d to start your project.");
}
