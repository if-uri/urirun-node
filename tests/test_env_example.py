import os
import unittest

class EnvExampleTests(unittest.TestCase):
    def _env_example_path(self):
        return os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), '.env.example')

    def test_env_example_exists(self):
        self.assertTrue(os.path.isfile(self._env_example_path()), '.env.example is missing')

    def test_env_example_has_node_placeholders(self):
        with open(self._env_example_path(), 'r', encoding='utf-8') as handle:
            content = handle.read()
        self.assertIn('URIRUN_NODE_', content)

    def test_env_example_lines_are_commented_or_key_value(self):
        with open(self._env_example_path(), 'r', encoding='utf-8') as handle:
            for line in handle:
                stripped = line.strip()
                if not stripped or stripped.startswith('#'):
                    continue
                self.assertIn('=', stripped, f'non key/value line: {stripped}')
                key, value = stripped.split('=', 1)
                self.assertTrue(key.strip(), f'empty key: {stripped}')
                self.assertTrue(value.strip(), f'empty value: {stripped}')

if __name__ == '__main__':
    unittest.main()
