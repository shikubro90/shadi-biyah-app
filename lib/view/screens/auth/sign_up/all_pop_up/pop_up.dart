import 'package:flutter/material.dart';
import 'package:matrimony/core/global/religion_caste_sect.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/religion_model/religion_model.dart';

class PersonalDetailsPopUps {
  static Future<void> generateCasteSectList({
    required BuildContext context,
    required List<Caste> castes,
    required Function(String) onItemSelected,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.left,
              text:
                  "${AppStaticStrings.select} ${ReligionSectCaste.casteSect}"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: castes.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(castes[index].name.toString()),
                  onTap: () {
                    onItemSelected(castes[index].name.toString());

                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  static void generateIndex({
    required BuildContext context,
    required int indexNumber,
    int startingValue = 0,
    required Function(int) onSelected,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: List.generate(indexNumber, (index) {
            final value = index + startingValue;
            return SimpleDialogOption(
              onPressed: () {
                onSelected(value);
                Navigator.of(context).pop();
              },
              child: CustomText(
                top: 6,
                bottom: 6,
                textAlign: TextAlign.left,
                text: value.toString(),
                fontSize: 16,
              ),
            );
          }),
        );
      },
    );
  }

  static void showYearDialog(
      {required BuildContext context, required Function(int) onYearSelected}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final int currentYear = DateTime.now().year;
        const int startYear = 1950;
        int endYear = currentYear;

        return SimpleDialog(
          children: List.generate(
            endYear - startYear + 1,
            (index) {
              final year = startYear + index;
              return SimpleDialogOption(
                onPressed: () {
                  onYearSelected(year);
                  Navigator.of(context).pop();
                },
                child: CustomText(
                  top: 6,
                  bottom: 6,
                  textAlign: TextAlign.left,
                  text: year.toString(),
                  fontSize: 16,
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Future<void> generateReligionList({
    required BuildContext context,
    required List<Religion> list,
    required List<Caste> castes,
    required Function(String) onCasteSectSelected,
    required Function(String) onItemSelected,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomText(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.left,
              text: AppStaticStrings.selectReligion),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(list[index].name.toString()),
                  onTap: () {
                    onItemSelected(list[index].name.toString());
                    onCasteSectSelected(ReligionSectCaste.casteSect =
                        list[index].castealias.toString());
                    castes.clear();
                    castes.addAll(list[index].castes!);

                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  static void generateListOfText(
      {required BuildContext context,
      required List<dynamic> list,
      required Function(String) onCountrySelected}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: List<Widget>.generate(
            list.length,
            (index) {
              final country = list[index];
              return SimpleDialogOption(
                onPressed: () {
                  onCountrySelected(country);
                  Navigator.of(context).pop();
                },
                child: CustomText(
                  top: 6,
                  bottom: 6,
                  textAlign: TextAlign.left,
                  text: country,
                  fontSize: 16,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class PopUpValueLists {
  //Personal Details
  static List<String> inchValues = List.generate(12, (index) => '${index}in');

  static List<String> ft = [
    "3ft",
    "4ft",
    "5ft",
    "6ft",
    "7ft",
  ];

  static List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  static List<String> residentialStatusList = [
    "Citizen",
    "Permanent Resident",
    "Temporary Resident",
    "Immigrant",
    "Refugee",
    "Other"
    // Add more residential statuses as needed
  ];

  static List<String> gender = [
    AppStaticStrings.male,
    AppStaticStrings.female,
  ];

  //Carrer Info

  static List<String> educationList = [
    "Some Schooling",
    "High School",
    "College",
    "Technical Training / Diploma",
    "Associates Degree",
    "Bachelors Degree",
    "Graduate / Masters Degree",
    "Professional Degree or PhD",
    "Other"
  ];

  static List<String> workExperienceList = [
    "Internship",
    "Entry-level Position",
    "Junior Level",
    "Mid-Level",
    "Senior Level",
    "Management",
    "Executive",
    "Freelance",
    "Contract Work",
    "Consultant",
    "Self-Employment"
  ];

  static List<String> occupationList = [
    "Accountant",
    "Actor",
    "Architect",
    "Artist",
    "Astronaut",
    "Athlete",
    "Biologist",
    "Chef",
    "Civil Engineer",
    "Computer Programmer",
    "Dentist",
    "Doctor",
    "Economist",
    "Electrician",
    "Entrepreneur",
    "Fashion Designer",
    "Firefighter",
    "Graphic Designer",
    "Human Resources Manager",
    "Interior Designer",
    "Journalist",
    "Judge",
    "Lawyer",
    "Librarian",
    "Mechanical Engineer",
    "Musician",
    "Nurse",
    "Occupational Therapist",
    "Pharmacist",
    "Photographer",
    "Physical Therapist",
    "Pilot",
    "Police Officer",
    "Professor",
    "Psychologist",
    "Real Estate Agent",
    "Research Scientist",
    "Student",
    "Social Worker",
    "Software Developer",
    "Teacher",
    "Translator",
    "Veterinarian",
    "Web Developer",
    "Writer",
    "Retired",
    "Other"
  ];

  static List<String> incomeList = [
    "No Income",
    "Under 50,000",
    "50,001 – 75,000",
    "75,001 – 100,000",
    "100,001 – 125,000",
    "125,001 – 150,000",
    "150,001 – 200,000",
    "200,001 – 300,000 ",
    "300,001 and above "
  ];

  //Social Details

  static List<String> motherTongueList = [
    "Balochi",
    "Sindhi",
    "Saraiki",
    "Punjabi",
    "Urdu",
    "Abkhaz",
    "Amharic",
    "Arabic",
    "Armenian",
    "Azerbaijani",
    "Bashkir",
    "Bengali",
    "Bhutanese",
    "Bulgarian",
    "Burmese",
    "Chechen",
    "Chuvash",
    "Croatian",
    "Czech",
    "Dutch",
    "Dzongkha",
    "English",
    "Estonian",
    "Farsi (Persian)",
    "Finnish",
    "French",
    "Georgian",
    "German",
    "Greek",
    "Hausa",
    "Hebrew",
    "Hindi",
    "Hungarian",
    "Indonesian",
    "Ingush",
    "Italian",
    "Japanese",
    "Kannada",
    "Kazakh",
    "Khmer",
    "Korean",
    "Kurdish",
    "Kyrgyz",
    "Lao",
    "Latvian",
    "Lithuanian",
    "Malagasy",
    "Malay",
    "Maldivian",
    "Mandarin Chinese",
    "Mongolian",
    "Nepali",
    "Ossetian",
    "Pashto",
    "Persian (Farsi)",
    "Polish",
    "Portuguese",
    "Punjabi",
    "Romanian",
    "Russian",
    "Serbian",
    "Sinhala",
    "Slovak",
    "Slovenian",
    "Somali",
    "Spanish",
    "Swahili",
    "Swedish",
    "Tagalog",
    "Tajik",
    "Tamil",
    "Tatar",
    "Telugu",
    "Thai",
    "Turkmen",
    "Turkish",
    "Ukrainian",
    "Urdu",
    "Uzbek",
    "Vietnamese",
    "Yoruba",
    "Zulu",
    "Other"
  ];

  static List<String> religionList = [
    "Islam",
    "Hinduism",
    "Christianity",
    "Buddhism",
    "Sikhism",
    "Judaism",
    "Bahá'í Faith",
    "Taoism",
    "Shinto",
    "Zoroastrianism",
    "Jainism",
    "Atheism",
    "Agnosticism",
    "Wicca",
    "Rastafarianism",
    "Hare Krishna",
    "Native American Religions",
    "Other"
  ];

  static List<String> maritalList = [
    "Never Married",
    "Awaiting Divorce",
    "Divorced",
    "Widowed",
    "Annulled",
    "Married"
  ];

//Family Details

  static List<String> numOfSiblings = ["None", "1", "2", "3", "3+"];
  static List<String> familyStatusList = [
    AppStaticStrings.richFamily,
    AppStaticStrings.upperMiddleClass,
    AppStaticStrings.middleClass
  ];
  static List<String> familyValuesList = [
    "Orthodox",
    "Conservative",
    "Moderate",
    "Liberal"
  ];

  static List<String> familyTypeList = [
    "Joint Family",
    "Nuclear Family",
    "Others"
  ];

  static List<String> motherOccupationList = [
    "Accountant",
    "Actor",
    "Architect",
    "Artist",
    "Astronaut",
    "Athlete",
    "Biologist",
    "Chef",
    "Civil Engineer",
    "Computer Programmer",
    "Dentist",
    "Doctor",
    "Economist",
    "Electrician",
    "Entrepreneur",
    "Fashion Designer",
    "Firefighter",
    "Graphic Designer",
    "Human Resources Manager",
    "Interior Designer",
    "Journalist",
    "Judge",
    "Lawyer",
    "Librarian",
    "House wife",
    "Mechanical Engineer",
    "Musician",
    "Nurse",
    "Occupational Therapist",
    "Pharmacist",
    "Photographer",
    "Physical Therapist",
    "Pilot",
    "Police Officer",
    "Professor",
    "Psychologist",
    "Real Estate Agent",
    "Research Scientist",
    "Student",
    "Social Worker",
    "Software Developer",
    "Teacher",
    "Translator",
    "Veterinarian",
    "Web Developer",
    "Writer",
    "Other"
  ];

//Partner Preferences
  static List<String> heightList = [
    "3ft 0in",
    "3ft 1in",
    "3ft 2in",
    "3ft 3in",
    "3ft 4in",
    "3ft 5in",
    "3ft 6in",
    "3ft 7in",
    "3ft 8in",
    "3ft 9in",
    "3ft 1 in",
    "3ft 11in",
    "4ft 0in",
    "4ft 1in",
    "4ft 2in",
    "4ft 3in",
    "4ft 4in",
    "4ft 5in",
    "4ft 6in",
    "4ft 7in",
    "4ft 8in",
    "4ft 9in",
    "4ft 10in",
    "4ft 11in",
    "5ft 0in",
    "5ft 1in",
    "5ft 2in",
    "5ft 3in",
    "5ft 4in",
    "5ft 5in",
    "5ft 6in",
    "5ft 7in",
    "5ft 8in",
    "5ft 9in",
    "5ft 10in",
    "5ft 11in",
    "6ft 0in",
    "6ft 1in",
    "6ft 2in",
    "6ft 3in",
    "6ft 4in",
    "6ft 5in",
    "6ft 6in",
    "6ft 7in",
    "6ft 8in",
    "6ft 9in",
    "6ft 10in",
    "6ft 11in",
    "7ft 0in",
    "7ft 1in",
    "7ft 2in",
    "7ft 3in",
    "7ft 4in",
    "7ft 5in",
    "7ft 6in",
    "7ft 7in",
    "7ft 8in",
    "7ft 9in",
    "7ft 10in",
    "7ft 11in",
  ];

  //Report List

  static List<String> reportList = [
    AppStaticStrings.harrasment,
    AppStaticStrings.inappropiateContent,
    AppStaticStrings.offensivelanguage,
    AppStaticStrings.disrespectfulbehavior,
    AppStaticStrings.threats,
    AppStaticStrings.other,
  ];

  static List<String> familyIncome = [
    "No Income",
    "Under 50,000",
    "50,001 – 75,000",
    "75,001 – 100,000",
    "100,001 – 125,000",
    "125,001 – 150,000",
    "150,001 – 200,000",
    "200,001 – 300,000",
    "300,001 and above"
  ];
}
