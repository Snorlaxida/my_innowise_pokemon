import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_innowise_pokemon/cubit/pokemon_details_cubit.dart';
import 'package:my_innowise_pokemon/model/pokemon_details.dart';

class PokemonDetailsView extends StatelessWidget {
  const PokemonDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailsCubit, PokemonDetails?>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state != null
                ? Text(state.name.toUpperCase())
                : const CircularProgressIndicator(),
          ),
          body: state != null
              ? Column(
                  children: [
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.memory(
                                  state.image,
                                ).image,
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          state.types.map((e) => _pokemonTypeView(e)).toList(),
                    ),
                    const SizedBox(height: 30),
                    Text.rich(TextSpan(
                      style: const TextStyle(fontSize: 20),
                      children: [
                        const TextSpan(text: "Height: "),
                        TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            text: '${state.height.toString()} cm'),
                      ],
                    )),
                    Text.rich(TextSpan(
                      style: const TextStyle(fontSize: 20),
                      children: [
                        const TextSpan(text: "Weight: "),
                        TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            text: '${state.weight.toString()} kg'),
                      ],
                    )),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget _pokemonTypeView(String type) {
  Color color;

  switch (type) {
    case 'normal':
      color = const Color(0xFFbdbeb0);
      break;
    case 'poison':
      color = const Color(0xFF995E98);
      break;
    case 'psychic':
      color = const Color(0xFFE96EB0);
      break;
    case 'grass':
      color = const Color(0xFF9CD363);
      break;
    case 'ground':
      color = const Color(0xFFE3C969);
      break;
    case 'ice':
      color = const Color(0xFFAFF4FD);
      break;
    case 'fire':
      color = const Color(0xFFE7614D);
      break;
    case 'rock':
      color = const Color(0xFFCBBD7C);
      break;
    case 'dragon':
      color = const Color(0xFF8475F7);
      break;
    case 'water':
      color = const Color(0xFF6DACF8);
      break;
    case 'bug':
      color = const Color(0xFFC5D24A);
      break;
    case 'dark':
      color = const Color(0xFF886958);
      break;
    case 'fighting':
      color = const Color(0xFF9E5A4A);
      break;
    case 'ghost':
      color = const Color(0xFF7774CF);
      break;
    case 'steel':
      color = const Color(0xFFC3C3D9);
      break;
    case 'flying':
      color = const Color(0xFF81A2F8);
      break;
    case 'fairy':
      color = const Color(0xFFEEB0FA);
      break;
    default:
      color = Colors.black;
      break;
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Text(
          type.toUpperCase(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
