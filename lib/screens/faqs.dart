import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class FaqsScreen extends StatefulWidget {
  @override
  _FaqsScreenState createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List<dynamic> faqs = [];
  List<String> categories = []; // Store unique categories
  String selectedCategory = 'All'; // Currently selected category
  bool isLoading = true;
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    fetchFaqs();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  Future<void> fetchFaqs() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/faqs.json');
    final data = jsonDecode(response);
    setState(() {
      faqs = data['results'];
      isLoading = false;

      // Extract unique categories
      Set<String> uniqueCategories = Set<String>();
      for (var faq in faqs) {
        uniqueCategories.add(faq['category']);
      }
      categories = ['All', ...uniqueCategories.toList()]; // Add 'All' option
    });
  }

  List<dynamic> getFilteredFaqs() {
    if (selectedCategory == 'All') {
      return faqs;
    } else {
      return faqs.where((faq) => faq['category'] == selectedCategory).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQs"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F9FF), Color(0xFFE9ECFF)],
          ),
        ),
        child: Column(
          children: [
            _buildCategoryFilter(),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        ListView.separated(
                          controller: _scrollController,
                          padding: EdgeInsets.only(
                              top: 20, left: 16, right: 16, bottom: 80),
                          itemCount:
                              getFilteredFaqs().length, // Use filtered FAQs
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final faq =
                                getFilteredFaqs()[index]; // Use filtered FAQs
                            return _buildFaqCard(faq, index);
                          },
                        ),
                        if (_scrollPosition > 100)
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: FloatingActionButton(
                              onPressed: () => _scrollController.animateTo(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut),
                              child: Icon(Icons.arrow_upward),
                              backgroundColor: Color(0xFF2575FC),
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        children:
            categories.map((category) => _buildCategoryChip(category)).toList(),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isActive = category == selectedCategory;
    return GestureDetector(
      // Make chip tappable
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(20),
          border: !isActive ? Border.all(color: Colors.grey.shade300) : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            category,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFaqCard(dynamic faq, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text(
          faq['question'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              faq['answer'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
        trailing: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF2575FC),
          size: 28,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
