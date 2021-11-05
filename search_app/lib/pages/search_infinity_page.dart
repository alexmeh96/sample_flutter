import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:search_app/api/meal_api.dart';
import 'package:search_app/model/meal.dart';
import 'package:search_app/widget/meal_item_widget.dart';
import 'package:search_app/widget/search_sliver_widget.dart';



class SearchInfinityPage extends StatefulWidget {
  SearchInfinityPage({Key key}) : super(key: key);

  @override
  _SearchInfinityPageState createState() => _SearchInfinityPageState();
}

class _SearchInfinityPageState extends State<SearchInfinityPage> {

  static const _pageSize = 17;

  final PagingController<int, Meal> _pagingController =
  PagingController(firstPageKey: 0);

  String _searchTerm;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });

    super.initState();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      final newItems = await MealApi.getMealList(
        pageKey,
        _pageSize,
        searchTerm: _searchTerm,
      );

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search local"),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SearchSliverWidget(
              hintText: "find meal",
              onChanged: (searchTerm) => _updateSearchTerm(searchTerm),
            ),
          ),
          PagedSliverList<int, Meal>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Meal>(
              itemBuilder: (context, item, index) => MealItemWidget(
                meal: item,
              ),
            ),
          ),
        ],
      )
    );
  }

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    super.dispose();
    // _pagingController.dispose();

  }

}