INSERT INTO demo.greeting (id, content) VALUES (1, 'Hello, World!') ON CONFLICT (id) DO NOTHING;
