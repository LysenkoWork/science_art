var age_categoryes = [
  'Детский тур (с 2011 г.р.)',
  'Студенческий тур (2000 - 2015 г.р.)',
  'Милениалы (1984 - 1999 г.р.)',
  'Профессиональный тур (до 1983 г.р.)'
];

var age_categoryes_min = ['Дети', 'Студенты', 'Профессионалы'];

var age_category_indexes = [0, 1, 2, 3];

var sections2 = [
  ['Графика', 'Живопись', 'Арт-обьект', 'Фотография'],
  ['Холст', 'Видеодизайн и анимация', 'Рисование и VR'],
  [
    'фотографика',
    'Иллюстрация',
    'Арт-обьект',
    'Панно',
    'IT технологии в искустве',
    'Арт-репортаж'
  ],
  [
    'фотографика',
    'Иллюстрация',
    'Арт-обьект',
    'Панно',
    'IT технологии в искустве',
    'Арт-репортаж'
  ]
];

var sectionsView = [
  'List of section',
  'IT В ИСКУССТВЕ',
  'АРТ РЕПОРТАЖ',
  '',
];

var otherSection = [
  'ХОЛСТ',
  'ВИДЕО-АНИМАЦИЯ',
  'ФОТОГРАФИКА',
  'ИЛЛЮСТРАЦИЯ',
  'АРТ-ОБЪЕКТ',
  'ПАННО',
  'РИСОВАНИЕ В VR',
];

var childsection = [
  'ГРАФИКА',
  'ЖИВОПИСЬ',
  'АРТ-ОБЪЕКТ',
  'ФОТОГРАФИЯ',
];

var sectionOptions = [
  'АРТ РЕПОРТАЖ',
  'IT В ИСКУССТВЕ',
  'ХОЛСТ',
  'Графика',
];

class Partner {
  String? id;
  String? name;
  String? photo;

  Partner(this.id, this.name, this.photo);
}

class Expert {
  String? id;
  String? name;
  String? job;
  String? photo;

  Expert(this.id, this.name, this.job, this.photo);
}

var partners = [
  Partner(
      '1', 'ООО "ARТЕЛЬ DIGITAL"', 'assets/partners/IMG-20230323-WA0017.jpg'),
  Partner('2', 'ООО "Экстраверт"', 'assets/partners/IMG-20230331-WA0032.jpg'),
  Partner(
      '3', 'Союз Дизайнеров России', 'assets/partners/IMG-20230331-WA0033.jpg'),
  Partner('4', 'Технопарк КубГУ "Точка Кипения" КубГУ',
      'assets/partners/IMG-20221010-WA0099.jpg'),
  Partner('5', 'ООО "Рекламный дом Кубани"',
      'assets/partners/IMG-20230402-WA0036.jpg'),
  Partner('6', 'газета "Кубанские новости"',
      'assets/partners/IMG-20230401-WA0006.jpg'),
  Partner('7', 'телеграм-канал "Наука и точка"',
      'assets/partners/IMG-20230401-WA0005.jpg')
];

var organizers = [
  Partner('1', 'Кафедра ДПИ и дизайна художественно-графического факультета',
      'assets/organizers/IMG-20230331-WA0018.jpg'),
  Partner(
      '2',
      'Кафедра анализа данных и искусственного интеллекта факультета компьютерных технологий и прикладной математики',
      'assets/organizers/IMG-20230331-WA0017.jpg'),
  Partner(
      '3',
      'МУ ДО "Детская художественная школа" им. В.А. Филиппова МО г. Краснодар',
      'assets/organizers/IMG-20230331-WA0016.jpg'),
  Partner(
      '4',
      'Кафедра истории и правового регулирования массовых коммуникаций факультета журналистики',
      'assets/organizers/IMG-20230331-WA0019.jpg'),
  Partner('5', 'Физико-технический факультет КубГУ',
      'assets/organizers/IMG-20230331-WA0021.jpg')
];

var experts = [
  Expert('1', 'Шарафан М.В.', 'Проректор по научной работе и инновациям КубГУ',
      'assets/experts/sharafan.jpg'),
  Expert('20', 'Фоменко Михаил', 'Настоящий знаток и ценитель',
      'assets/experts/fomenko.jpg'),
  Expert(
      '2',
      'Коробко Ю.В.',
      'Декан художественно-графического факультета КубГУ',
      'assets/experts/Korobko.jpg'),
  Expert('19', 'Соколова', 'Настоящий знаток и ценитель',
      'assets/experts/sokolova.jpg'),
  Expert(
      '3',
      'Морозкина Е.А.',
      'Председатель орг комитета выставки-конкурса, зав. кафедры ДПИ и дизайна ХГФ КубГУ',
      'assets/experts/morozkina.jpg'),
  Expert('5', 'Копанева О.В.', 'Директор Технопарка КубГУ',
      'assets/experts/koponeva.jpg'),
  Expert('6', 'Волкова Т.А.', 'Программный директор «Точка кипения КубГУ»',
      'assets/experts/volkova.jpg'),
  Expert(
      '7',
      'Коваленко А.В.',
      'Зав. кафедры анализа данных и искусственного интеллекта факультета компьютерных технологий и прикладной математики КубГУ',
      'assets/experts/kovalenko.jpg'),
  Expert(
      '8',
      'Лучинский Ю.В.',
      'Зав. кафедры истории и правового регулирования массовых коммуникаций КубГУ',
      'assets/experts/lychinskiy.jpg'),
  Expert(
      '9',
      'Зимина О.А.',
      'Председатель Краснодарского регионального отделения общественной организации «Союз дизайнеров России», и.о. декана факультета архитектуры и дизайна, зав. кафедры «Дизайн одежды» ФАД КубГУ',
      'assets/experts/zimina.jpg'),
  Expert('10', 'Говорова Г.Н.', 'Директор Департамента по международным связям',
      'assets/experts/govorova.jpg'),
  Expert(
      '11',
      'Ротай Е.М.',
      'Зам. директора Департамента по международным связям',
      'assets/experts/rotai.jpg'),
  Expert(
      '4',
      'Денисенко В.И.',
      'Профессор кафедры живописи, зам. декана по науке ХГФ КубГУ',
      'assets/experts/denisenko.jpg'),
  Expert('21', 'Мальцева Л.В.', 'Доктор педагогических наук, доцент',
      'assets/experts/maltseva.jpg'),
  Expert(
      '12',
      'Белая Т.В.',
      'Доцент кафедры ДПИ и дизайна ХГФ КубГУ, зам. декана по учебной работе ХГФ',
      'assets/experts/belpay.jpg'),
  Expert(
      '13',
      'Прокопова А.С',
      'Ст. преподаватель кафедры ДПИ и дизайна ХГФ КубГУ',
      'assets/experts/prokopova.jpg'),
  Expert(
      '14',
      'Полонникова А.А.',
      'Преподаватель кафедры ДПИ и дизайна ХГФ КубГУ',
      'assets/experts/polonnikova.jpg'),
  Expert(
      '15',
      'Присяжнюк В.С.',
      'Директор детской художественной школы им В.А.Филиппова',
      'assets/experts/prosygnik.jpg'),
  Expert('16', 'Шведчиков Н.Ю.', 'Генеральный директор ООО Экстраверт',
      'assets/experts/svedchikov.jpg'),
  Expert('17', 'Золотарёв С.С.', 'Генеральный директор ООО «М-АРТ»',
      'assets/experts/zolotarev.jpg'),
  Expert('18', 'Зыкова Е.В.', 'Управляющий партнёр «ARTEЛЬ DIGITAL»',
      'assets/experts/zikova.jpg'),
];

class User {
  String? id;
  String? name;
  String? pass;
  String? type;
  String? email;
  String? phone;
  String? photo;

  User({this.id, this.name, this.pass, this.type, this.email, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pass = json['pass'];
    type = json['type'];
    email = json['email'];
    phone = json['phone'];
    phone = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pass'] = pass;
    data['type'] = type;
    data['email'] = email;
    data['phone'] = phone;
    data['phone'] = photo;
    return data;
  }
}

/*
CREATE TABLE candidate (
  id int NOT NULL AUTO_INCREMENT,
  name text,
  surname text,
  patronymic text,
  age_category text,
  job text,
  email text,
  section text,
  phone_number text,
  leadership text,
  insert_date text,
  description text,
  update_date text,
  filename text,
  PRIMARY KEY (id) );
*/
