import requests

my_list = [-1, 0, 1, 2, 3, 4, 'hello']

for item in my_list:
    response = requests.get('http://localhost:5050/isEven?number={}'.format(item))
    print(response.text)
    assert response.status_code == 200, 'Test Fail {}'.format(response.status_code)
    if item % 2 == 0:
        assert response.text == 'Even'
    else:
        assert response.text == 'Odd'
