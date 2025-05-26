## Explain the Primary Key and Foreign Key concepts in PostgreSQL.

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
```
sql
Copy
Edit
CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_name VARCHAR(100)
);
```

