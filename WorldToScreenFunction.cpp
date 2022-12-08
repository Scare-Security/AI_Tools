#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

int main()
{
  // Define the world coordinates of the point
  glm::vec3 world_coords = glm::vec3(1.0f, 1.0f, 1.0f);

  // Define the view and projection matrices
  glm::mat4 view = glm::lookAt(glm::vec3(0.0f, 0.0f, 0.0f),
                               glm::vec3(0.0f, 0.0f, 1.0f),
                               glm::vec3(0.0f, 1.0f, 0.0f));
  glm::mat4 projection = glm::perspective(glm::radians(45.0f),
                                          800.0f / 600.0f,
                                          0.1f, 100.0f);

  // Perform the world-to-screen transformation
  glm::vec3 screen_coords = glm::project(world_coords, view, projection,
                                         glm::vec4(0, 0, 800, 600));

  // Print the screen coordinates
  std::cout << "Screen coordinates: (" << screen_coords.x
            << ", " << screen_coords.y << ")" << std::endl;

  return 0;
}
/*
This code defines the world coordinates of a point and the view and projection matrices. It then uses the glm::project function to perform the world-to-screen transformation and prints the resulting screen coordinates.

Note that the glm::project function takes in the dimensions of the screen as the fourth parameter. In this example, the screen dimensions are 800 x 600, so the fourth parameter is glm::vec4(0, 0, 800, 600). You should replace this with the actual dimensions of the screen you are using.
*/
