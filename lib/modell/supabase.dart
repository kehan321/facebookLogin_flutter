import 'package:supabase/supabase.dart';

// Replace these values with your actual Supabase URL and anon key
const String supabaseUrl = 'https://xnfmnmqgkaircknxijmr.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhuZm1ubXFna2FpcmNrbnhpam1yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE3NDE0MDUsImV4cCI6MjAzNzMxNzQwNX0.JebiutGiRUGpdbjZKJB78mD2e6DaFNCNh2XXzKMcciA';

class SupabaseClientService {
  static final SupabaseClient _client = SupabaseClient(supabaseUrl, supabaseAnonKey);

  static SupabaseClient get client => _client;
}
