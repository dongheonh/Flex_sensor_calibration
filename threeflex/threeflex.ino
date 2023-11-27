void setup() {
  // Start the serial communication
  Serial.begin(9600);
}

void loop() {
  // Read analog values from pins A0, A1, and A2
  int valueA0 = analogRead(A0);
  int valueA1 = analogRead(A1);
  int valueA2 = analogRead(A2);

  // Print the values in CSV format
  Serial.print(valueA0);
  Serial.print(",");
  Serial.print(valueA1);
  Serial.print(",");
  Serial.println(valueA2); // 'println' adds a new line after printing valueA2

  // Wait for a short time before the next reading
  delay(1000); // Delay in milliseconds (1000 ms = 1 second)
}
