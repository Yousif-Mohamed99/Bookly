import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/search_cubit/search_cubit.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/search_cubit/search_state.dart';
import 'package:novella/Features/books/views/widgets/newest_book_item.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  bool _isButtonDisabled = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Books'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Input Field
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by book name...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onChanged: (query) {
                  context.read<SearchCubit>().searchBooks(query);
                },
              ),
              const SizedBox(height: 16),

              // Search Button
              BlocListener<SearchCubit, SearchState>(
                listener: (context, state) {
                  if (state is SearchSuccess || state is SearchFailure) {
                    setState(() {
                      _isButtonDisabled = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() {
                          _isButtonDisabled = false;
                        });
                      }
                    });
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed:
                        _isButtonDisabled
                            ? null
                            : () {
                              context.read<SearchCubit>().submitSearch(
                                _searchController.text,
                              );
                            },
                    icon: const Icon(Icons.search, color: Colors.blueAccent),
                    label: const Text(
                      'Search',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Results
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const Center(
                      child: Text(
                        'Start typing to search for books',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  } else if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchSuccess) {
                    if (state.books.isEmpty) {
                      return const Center(
                        child: Text(
                          'No books found',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: BestSellerItem(bookModel: state.books[index]),
                        );
                      },
                    );
                  } else if (state is SearchFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
