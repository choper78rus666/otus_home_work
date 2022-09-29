// Файл конфигурации рецептов
const List<Map<String, dynamic>> recipeList = [
  {
    'imagePaths': {
      'mini': 'assets/images/recipient_mini.png',
      'detail': 'assets/images/recipe_detail.png',
    },
    'title': 'Лосось в соусе терияки',
    'time': 45,
    'ingredientsList': [
      {'id': 0, 'count': '8 ст. ложек'},
      {'id': 1, 'count': '8 ст. ложек'},
      {'id': 2, 'count': '3 ст. ложки'},
      {'id': 3, 'count': '2 ст. ложки'},
      {'id': 4, 'count': '3 зубчика'},
      {'id': 5, 'count': '1 ст. ложка'},
      {'id': 6, 'count': '1¹⁄₂ ст. ложки'},
      {'id': 7, 'count': '1 ст. ложка'},
      {'id': 8, 'count': '1 ч. ложка'},
      {'id': 9, 'count': '680 г'},
      {'id': 10, 'count': ''},
    ],
    'steps': [
      {
        'time': 6,
        'description':
            'В маленькой кастрюле соедините соевый соус, 6 столовых ложек воды, мёд, сахар, измельчённый чеснок, имбирь и лимонный сок.'
      },
      {
        'time': 7,
        'description':
            'Поставьте на средний огонь и, помешивая, доведите до лёгкого кипения.'
      },
      {
        'time': 6,
        'description':
            'Смешайте оставшуюся воду с крахмалом. Добавьте в кастрюлю и перемешайте.'
      },
      {
        'time': 1,
        'description':
            'Готовьте, непрерывно помешивая венчиком, 1 минуту. Снимите с огня и немного остудите.'
      },
      {
        'time': 6,
        'description':
            'Смажьте форму маслом и выложите туда рыбу. Полейте её соусом.'
      },
      {
        'time': 15,
        'description':
            'Поставьте в разогретую до 200 °C духовку примерно на 15 минут.'
      },
      {
        'time': 4,
        'description':
            'Перед подачей полейте соусом из формы и посыпьте кунжутом.'
      },
    ],
  },
  {
    'imagePaths': {
      'mini': 'assets/images/recipient_mini2.png',
      'detail': '',
    },
    'title': 'Поке боул с сыром тофу',
    'time': 30,
  },
  {
    'imagePaths': {
      'mini': 'assets/images/recipient_mini3.png',
      'detail': '',
    },
    'title': 'Стейк из говядины по-грузински с кукурузой',
    'time': 75,
  },
  {
    'imagePaths': {
      'mini': 'assets/images/recipient_mini4.png',
      'detail': '',
    },
    'title': 'Тосты с голубикой и бананом',
    'time': 45,
  },
  {
    'imagePaths': {
      'mini': 'assets/images/recipient_mini5.png',
      'detail': '',
    },
    'title': 'Паста с морепродуктами',
    'time': 25,
  },
  {
    'imagePaths': {
      'mini': 'assets/images/recipient_mini6.png',
      'detail': '',
    },
    'title': 'Бургер с двумя котлетами',
    'time': 60,
  },
  {
    'imagePaths': {
      'mini': 'assets/images/recipient_mini7.png',
      'detail': 'assets/images/recipe_detail7.png',
    },
    'title': 'Пицца Маргарита домашняя',
    'time': 25,
    'ingredientsList': [

  {'id': 11, 'count': '300 грам'},
      {'id': 12, 'count': '130 грам'},
      {'id': 13, 'count': '180 грам'},
      {'id': 14, 'count': '1 шт.'},
      {'id': 15, 'count': '1 шт.'},
      {'id': 16, 'count': '1 ч. ложка'},
    ],
    'steps': [
      {
        'time': 1,
        'description':
            'В Тесто для пиццы раскатываем толщиной 2-3 мм, диаметром 32-35 см.  Для того, чтобы получить красивые бортики на пицце, загибаем края по 2-3 см внутрь и хорошо залепляем, чтобы при выпекании они не отклеились.'
      },
      {
        'time': 1,
        'description':
            'Кладём на раскатанную основу томатный соус, пусть его будет побольше, особенное если вы используете не кетчуп или томатную пасту, а соус из помидоров.'
      },
      {
        'time': 1,
        'description':
            'Равномерно распределяем соус по тесту, поливаем сверху оливковым маслом.'
      },
      {
        'time': 10,
        'description':
            'Духовку разогреваем до максимальной температуры (250-270°С), ставим перевёрнутый противень с тестом на нижний уровень и выпекаем в течении 5-10 минут'
      },
      {
        'time': 1,
        'description':
            'Пока запекается корж, нарезаем моцареллу пластинами 5-10 мм толщиной.'
      },
      {'time': 1, 'description': 'Нарезаем помидор ломтиками 3-5 мм.'},
      {
        'time': 10,
        'description':
            'Кладем сыр, помидоры и базилик на основу, ставим в духовку еще на 10 минут. Пицца готова, когда сыр расплавится.'
      },
    ]
  },
];
