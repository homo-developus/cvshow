# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cv = Cv.create(birthday: 30.years.ago, email: 'test@email.com', phone: '+1(234)567-89-01', skype: 'test_skype')

cv_en = cv.cv_trans.create(
    tran_lang: :en,
    full_name: 'Tom Smith',
    position: 'Ruby on Rails Developer',
    marital_status: 'married',
    address: 'Earth',
    summary: 'Extremely well-trained and skilled Ruby on Rails Developer with vast experience in web design for a variety of corporate clients. Adept at adjusting work pace to satisfy evolving client needs. Superb record of project completion at or well before deadlines.',
    personal_skills: 'Fast learner, logical thinking, active',
    technical_skills: {
        proficient: 'AJAX, Apache, ASP, Bash, CSS, Capistrano, Debian, Git, Haml, HTML, ImageMagick, JQuery, JavaScript, JSON, Linux, MySQL, OSX, Passenger, PostgreSQL, Pow, RSpec, Ruby, Ruby on Rails, RVM, Sass, SQL, SQLite, Vim, XML',
        knowledgable: 'CGI, DHCP, DNS, Dovecot, EC2, FTP, IMAP, Munin, Middleman, Nagios, PHP, Pixelmator, POP, Perl, Postfix, RSS, S3, Stasis, Windows',
        'used previously': 'C, C++, Oracle, Coldfusion, Java, Photoshop, Gimp'
    },
    qualification: [
        'Excellent Ruby on Rails development experience',
        'Exceptional knowledge of Ruby on Rails framework',
        'Strong experience in using Ruby on Rails in a UNIX/LINUX environment'
    ],
    links: {
        facebook: 'https://www.facebook.com/cnninternational/',
        github: 'https://github.com/nationalparkservice'
    },
    languages: {
        english: 'intermediate',
        russian: 'native'
    }
)

cv_ru = cv.cv_trans.create(
    tran_lang: :ru,
    full_name: 'Том Смит',
    position: 'Разработчик Ruby on Rails',
    marital_status: 'женат',
    address: 'Земля',
    summary: 'Супер специалист :)',
    personal_skills: 'Обучаемость, логическое мышление, активность',
    technical_skills: {
        опытный: 'AJAX, Apache, ASP, Bash, CSS, Capistrano, Debian, Git, Haml, HTML, ImageMagick, JQuery, JavaScript, JSON, Linux, MySQL, OSX, Passenger, PostgreSQL, Pow, RSpec, Ruby, Ruby on Rails, RVM, Sass, SQL, SQLite, Vim, XML',
        знающий: 'CGI, DHCP, DNS, Dovecot, EC2, FTP, IMAP, Munin, Middleman, Nagios, PHP, Pixelmator, POP, Perl, Postfix, RSS, S3, Stasis, Windows',
        'использовалось ранее': 'C, C++, Oracle, Coldfusion, Java, Photoshop, Gimp'
    },
    qualification: [
        'Большой опыт разработки на Ruby on Rails',
        'Превосходные знания Ruby on Rails фреймворка',
        'Уверенный опыт...'
    ],
    links: {
        фейсбук: 'https://www.facebook.com/cnninternational/',
        гитхаб: 'https://github.com/nationalparkservice'
    },
    languages: {
        английский: 'средний',
        русский: 'родной'
    }
)

cv_en.educations.create([{
                             degree: 'Bachelor\'s Degree',
                             specialty: 'Computer Science',
                             institution: 'University of Michigan',
                             year: 2007,
                             institution_address: 'Ann Arbor, MI'
                         },{
                             degree: 'Associate\'s Degree',
                             institution: 'Upper Detroit Community College',
                             year: 2004
}])

cv_ru.educations.create([{
                             degree: 'Бакалавр',
                             specialty: 'Компьютерные Науки',
                             institution: 'Мичиганский Университет',
                             year: 2007,
                             institution_address: 'Энн Арбор, МИ'
                         },{
                             degree: 'Младший специалист',
                             institution: 'Высший колледж Детройта',
                             year: 2004
                         }])

cv_en_exp_1 = Experience.create(
    started_at: 3.years.ago,
    position: 'Ruby on Rails Developer',
    company: 'ABC Company',
    company_site: 'www.abccompany.com',
    company_address: 'Earth',
    duties: [
        'Developed Ruby on Rails applications.',
        'Supported product migration and platform upgrades.'
    ]
)
cv_en.experiences << cv_en_exp_1
cv_en_exp_1.projects.create([{
                                 name: 'Project 1',
                                 description: 'Cool and useful project',
                                 link: 'www.project1link.com',
                                 technologies: 'Ruby on Rails, JavaScript, JQuery, HTML, CSS'
                             },
                             {
                                 name: 'Project 2',
                                 link: 'www.project2link.com',
                             }
                            ]
)

cv_ru_exp_1 = Experience.create(
    started_at: 3.years.ago,
    position: 'Разработчик Ruby on Rails',
    company: 'ABC Company',
    company_site: 'www.abccompany.com',
    company_address: 'Земля',
    duties: [
        'Разрабатывал Ruby on Rails приложения',
        'Занимался поддержкой миграций продуктов и обновлений платформы.'
    ]
)
cv_ru.experiences << cv_ru_exp_1
cv_ru_exp_1.projects.create([{
                                 name: 'Проект 1',
                                 description: 'Крутой и полезный проект',
                                 link: 'www.project1link.com',
                                 technologies: 'Ruby on Rails, JavaScript, JQuery, HTML, CSS'
                             },
                             {
                                 name: 'Проект 2',
                                 link: 'www.project2link.com',
                             }
                            ]
)

cv_en_exp_2 = Experience.create(
    started_at: 6.years.ago,
    finished_at: 3.years.ago - 1.day,
    position: 'Software Developer',
    company: 'XYZ Company',
    company_address: 'Earth'
)
cv_en.experiences << cv_en_exp_2

cv_ru_exp_2 = Experience.create(
    started_at: 6.years.ago,
    finished_at: 3.years.ago - 1.day,
    position: 'Разработчик програмного обеспечения',
    company: 'XYZ Company',
    company_address: 'Земля'
)
cv_ru.experiences << cv_ru_exp_2
