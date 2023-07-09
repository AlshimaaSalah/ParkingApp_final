import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'blocs/bloc/autocomplete_bloc.dart';

class HomeSearchBox extends StatelessWidget {
  const HomeSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Enter to search',
            suffixIcon: Icon(Icons.search),
            contentPadding:
                const EdgeInsets.only(left: 20, bottom: 5, right: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          onChanged: (value) {
            print(value);
            final sessiontoken = Uuid().v4();
            context.read<AutocompleteBloc>().add(LoadAutocomplete(
                searchInput: value, sessiontoken: sessiontoken));
          },
        );
      },
    );
  }
}
