import 'package:filmfolio/controllers/award_controller.dart';
import 'package:filmfolio/controllers/content_controller.dart';
import 'package:filmfolio/controllers/crew_controller.dart';
import 'package:filmfolio/controllers/user_controller.dart';
import 'package:filmfolio/controllers/usercontent_controller.dart';
import 'package:filmfolio/models/award.dart';
import 'package:filmfolio/models/crew.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/models/user.dart';
import 'package:filmfolio/services/nottification_service.dart';
import 'package:filmfolio/ui/widgets/award_section.dart';
import 'package:filmfolio/ui/widgets/basic_info_fields.dart';
import 'package:filmfolio/ui/widgets/category_section.dart';
import 'package:filmfolio/ui/widgets/crew_section.dart';
import 'package:filmfolio/ui/widgets/duration_field.dart';
import 'package:filmfolio/ui/widgets/photo_inputs_section.dart';
import 'package:filmfolio/ui/widgets/release_date_picker.dart';
import 'package:filmfolio/ui/widgets/storyline_language.dart';
import 'package:filmfolio/ui/widgets/video_input.dart';
import 'package:flutter/material.dart';

class AddMoviePage extends StatefulWidget {
  final Movie? movie;
  const AddMoviePage({Key? key, this.movie}) : super(key: key);

  @override
  _AddMoviePageState createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  final CrewController _crewController = CrewController();
  final AwardController _awardController = AwardController();
  final UserController _userController = UserController();
  User? _user;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _directorController = TextEditingController();
  final _storylineController = TextEditingController();
  final _languageController = TextEditingController();
  final _durationController = TextEditingController();

  DateTime? _releaseDate;
  bool _isMovie = false;
  List<String> _selectedCrew = [];
  List<String> _selectedCategories = [];
  List<Award> _selectedAwards = [];
  List<String> _photos = [];
  String? _trailerUrl;

  List<Award>? _allAwards;
  List<Crew> _selectedCrewList = [];
  List<Crew> crewList = [];
  List<Award> awardList = [];

  final List<String> _allCategories = [
    "Anime", "Horror", "Romantic", "Science-fiction", "Action",
    "Comedy", "Documentary", "Drama", "Fantasy", "Mystery", "Thriller",
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();

    if (widget.movie != null) {
      _initializeFormFields();
    }
  }

  void _fetchData() async {
    crewList = await _crewController.getAllCrew();
    awardList = await _awardController.getAllAwards();
    _user = await _userController.loadUserFromLocalStorage();
    setState(() {
      _allAwards = awardList;
    });
  }


  void _initializeFormFields() {
    _nameController.text = widget.movie!.name;
    _directorController.text = widget.movie!.director;
    _storylineController.text = widget.movie!.storyline;
    _languageController.text = widget.movie!.language;
    _durationController.text = widget.movie!.duration.toString();
    _releaseDate = widget.movie!.releaseDate;
    _isMovie = widget.movie!.isMovie;
    _selectedCategories = widget.movie!.categories;
    _photos = widget.movie!.photos;
    _trailerUrl = widget.movie!.trailer;
    _selectedCrewList = widget.movie!.crew;
    _selectedAwards = widget.movie!.awards!;
    _selectedCrew = _selectedCrewList.map((c) => c.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_allAwards == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie != null ? 'Edit Movie/Show' : 'Add New Movie/Show'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicInfoFields(
                nameController: _nameController,
                directorController: _directorController,
                isMovie: _isMovie,
                onIsMovieChanged: (value) => setState(() => _isMovie = value),
              ),
              const SizedBox(height: 12),
              PhotoSection(
                photos: _photos,
                showname: _nameController.text,
                onPhotosChanged: (newPhotos) =>
                    setState(() => _photos = newPhotos),
              ),
              const SizedBox(height: 12),
              CategorySection(
                allCategories: _allCategories,
                selectedCategories: _selectedCategories,
                onCategorySelected: (category, selected) {
                  setState(() {
                    if (selected) {
                      _selectedCategories.add(category);
                    } else {
                      _selectedCategories.remove(category);
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              StorylineAndLanguageFields(
                storylineController: _storylineController,
                languageController: _languageController,
              ),
              const SizedBox(height: 12),
              ReleaseDatePicker(
                releaseDate: _releaseDate,
                onDateSelected: (date) => setState(() => _releaseDate = date),
              ),
              const SizedBox(height: 12),
              DurationField(controller: _durationController),
              const SizedBox(height: 12),
              CrewSection(
                selectedCrew: _selectedCrew,
                crewList: crewList,
                onCrewSelected: (member, selected) {
                  setState(() {
                    if (selected) {
                      _selectedCrew.add(member);
                      Crew? selectedCrewMember =
                      crewList.firstWhere((c) => c.name == member);
                      if (selectedCrewMember != null) {
                        _selectedCrewList.add(selectedCrewMember);
                      }
                    } else {
                      _selectedCrew.remove(member);
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              AwardsSection(
                allAwards: _allAwards!,
                selectedAwards: _selectedAwards,
                onAwardSelected: (award, selected) {
                  setState(() {
                    if (selected) {
                      _selectedAwards.add(award);
                    } else {
                      _selectedAwards.remove(award);
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              VideoInput(
                  showname: _nameController.text,
                  onVideoUploaded: (url) => _trailerUrl = url),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.movie != null ? 'Update Movie/Show' : 'Add Movie/Show'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final movieId = widget.movie?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
      final newMovie = Movie(
        id: movieId,
        name: _nameController.text,
        director: _directorController.text,
        rating: widget.movie?.rating ?? 0.0,
        popularity: widget.movie?.popularity ?? 0,
        isMovie: _isMovie,
        thumbnailUrl: _photos.isNotEmpty ? _photos[0] : '',
        trailer: _trailerUrl ?? '',
        photos: _photos,
        categories: _selectedCategories,
        storyline: _storylineController.text,
        language: _languageController.text,
        duration: int.tryParse(_durationController.text) ?? 0,
        releaseDate: _releaseDate!,
        crew: _selectedCrewList,
        awards: _selectedAwards,
      );

      final UserContentController _usercontentcontroller = UserContentController();
      final ContentController _contentController = ContentController();

      if (widget.movie == null) {
        await _usercontentcontroller.addUserContent(_user!.id, newMovie.id);
        await _contentController.addMovie(newMovie);

        // Send notifications based on user's admin status
        if (_user?.isAdmin ?? false) {
          await NotificationService().sendAdminNotification(
            title: 'New Movie Added',
            body: '${newMovie.name} is added by ${_user!.name}',
          );
          await NotificationService().sendNotificationToAllUsers(newMovie.name);

        } else {
          await NotificationService().sendNotificationToAllUsers(newMovie.name);
        }
      } else {
        final updatedMovieJson = newMovie.toJson();
        await _contentController.updateMovie(newMovie.id, updatedMovieJson);
      }

      Navigator.of(context).pop();
    }
  }



}
