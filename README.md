## 1. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

### Primary Key:
Primary Key হলো একটি টেবিলের কলাম (বা অনেকগুলি কলাম), যেটা টেবিলের প্রতিটি সারিকে অনন্যভাবে শনাক্ত করে। একটি টেবিলে শুধুমাত্র একটি Primary Key থাকতে পারে।

**উদাহরণ:**
```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT
);
```

### Foreign Key:
Foreign Key এমন একটি কলাম যা অন্য একটি টেবিলের Primary Key-এর সাথে সম্পর্ক তৈরি করে। এটি অনেকগুলি টেবিল এর মধ্যে রিলেশন তৈরি করতে ব্যবহৃত হয়।

**উদাহরণ:**
```sql
CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_name VARCHAR(100)
);
```


## 2. What is the difference between the VARCHAR and CHAR data types?

| বৈশিষ্ট্য         | `CHAR(n)`                         | `VARCHAR(n)`                     |
|----------------|-----------------------------------|----------------------------------|
| দৈর্ঘ্য            | নির্দিষ্ট (Fixed Length)              | পরিবর্তনশীল (Variable Length)     |
| স্টোরেজ         | সবসময় `n` ক্যারেক্টার স্টোর করে     | যতটুকু প্রয়োজন ততটুকু স্টোর করে    |
| পারফরম্যান্স      | সামান্য বেশি দ্রুত (কিছু ক্ষেত্রে)       |  মেমোরি বাঁচায়                     |

**উদাহরণ:**
```sql
-- CHAR(5)
INSERT INTO demo_char VALUES ('Hi'); -- স্টোর করে: 'Hi   '

-- VARCHAR(5)
INSERT INTO demo_varchar VALUES ('Hi'); -- স্টোর করে: 'Hi'
```


## 3. Explain the purpose of the WHERE clause in a SELECT statement.
`WHERE` ক্লজ SQL-এ ডেটা ফিল্টার করার জন্য ব্যবহৃত হয়, যা কেবলমাত্র নির্দিষ্ট শর্ত পূরণকারী রেকর্ডগুলো রিটার্ন করে।

**উদাহরণ:**
```sql
SELECT * FROM students
WHERE age > 18;
```

এটি শুধুমাত্র ১৮ বছরের বেশি বয়সী শিক্ষার্থীদের রিটার্ন করবে।


## 4. What are the LIMIT and OFFSET clauses used for?
### LIMIT:
নির্দিষ্ট সংখ্যক রেকর্ড রিটার্ন করতে ব্যবহৃত হয়।

```sql
SELECT * FROM users LIMIT 5;
```

### OFFSET:
নির্দিষ্ট সংখ্যক সারি স্কিপ করতে ব্যবহৃত হয়।

```sql
SELECT * FROM users OFFSET 5;
```


**উদাহরণ:**
```sql
SELECT * FROM students
ORDER BY student_id
LIMIT 5 OFFSET 10;
```

এটি প্রথম ১০টি রেকর্ড বাদ দিয়ে পরবর্তী ৫টি রিটার্ন করবে।

## 5. How can you modify data using UPDATE statements?
`UPDATE` স্টেটমেন্টের মাধ্যমে বিদ্যমান রেকর্ডের তথ্য পরিবর্তন করা যায়। সাধারণত `WHERE` ক্লজসহ এটি ব্যবহার করা হয় যাতে নির্দিষ্ট রেকর্ড টার্গেট করার যায়।

**উদাহরণ:**
```sql
UPDATE students
SET age = 21
WHERE student_id = 1;
```

এটি `student_id = 1` শিক্ষার্থীর বয়স ২১ করে দিবে।

